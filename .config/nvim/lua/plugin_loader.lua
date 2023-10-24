local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local pack_dotfiles_path = vim.fn.stdpath("data") .. "/site/pack/dotfiles/opt"
local spec_module_dir = vim.fn.stdpath("config") .. "/lua/dotfiles/module/plugin"

local spec_module_cache = {}

local function load_lib(package_name, clone_url, branch)
  local install_path = pack_dotfiles_path .. "/" .. package_name

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd(string.format("!git clone -b %s %s %s", branch, clone_url, install_path))
  end

  vim.cmd("packadd " .. package_name)
end

local function load_lazy()
  if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazy_path
    }
  end

  vim.opt.rtp:prepend(lazy_path)
end

local function strip_extensions(str)
  local result = {}

  for token in string.gmatch(str, ".") do
    if token ~= "." then
      table.insert(result, token)
    else
      break
    end
  end

  return table.concat(result, "")
end

local function get_workspace_excluded_plugins()
  local utils = require "dotfiles.util"

  return utils["get-var"]("packer_excluded_plugins") or {}
end

local function bootstrap()
  load_lib("aniseed", "https://github.com/Olical/aniseed", "v3.24.0")

  -- Compile all fennel before we do anything...
  -- Note, don't load anything... just compile.
  require "aniseed.env".init({module = "dotfiles"})
end

local function is_plugin_workspace_excluded(plugin)
  local excluded_plugins = get_workspace_excluded_plugins()

  return vim.tbl_contains(excluded_plugins, plugin)
end

local function has_spec_module(spec_name)
  if spec_module_cache[spec_name] ~= nil then
    return spec_module_cache[spec_name]
  end

  local file = io.open(spec_module_dir .. "/" .. spec_name .. ".lua", "r")

  if file ~= nil then
    io.close(file)
    spec_module_cache[spec_name] = true

    return true
  end

  spec_module_cache[spec_name] = false

  return false
end

local function call_spec_module(spec_name, module_name, method, ...)
  if has_spec_module(spec_name) then
    local mod = require(module_name)

    if type(mod[method]) == "function" then
      return mod[method](...)
    end
  end

  return nil
end

local function is_mode_enabled(modes, default)
  if vim.env.STEELVIM_MODE ~= nil then
    if type(modes) == "table" then
      return vim.tbl_contains(modes, vim.env.STEELVIM_MODE)
    else
      return default
    end
  end

  return true
end

-- Plugin modules are associated by the plugin name MINUS any extensions.
-- So, pears.nvim would become just "pears".
local function make_module_spec(spec)
  if type(spec) == "string" then
    spec = {spec}
  end

  local spec_name = spec.name or strip_extensions(vim.fn.fnamemodify(spec[1], ":t"))
  local module_name = string.format(
    "dotfiles.module.plugin.%s",
    strip_extensions(spec_name)
  )

  if not spec.init then
    spec.init = function(plugin)
      call_spec_module(spec_name, module_name, "setup", plugin)
    end
  end

  if not spec.build then
    spec.build = function(plugin)
      call_spec_module(spec_name, module_name, "build", plugin)
    end
  end

  if not spec.config then
    spec.config = function(plugin, opts)
      call_spec_module(spec_name, module_name, "configure", plugin, opts)
    end
  end

  local spec_cond = spec.cond

  spec.cond = function(plugin)
    local spec_result = true

    if type(spec_cond) == "boolean" then
      spec_result = spec_cond
    elseif type(spec_cond) == "function" then
      spec_result = spec_cond(plugin)
    end

    local module_result = call_spec_module(spec_name, module_name, "cond", plugin)

    if module_result == nil then
      module_result = true
    end

    -- Don't load the plugin if it's not enabled for a certain mode
    local mode_result = is_mode_enabled(spec.modes, false)

    return (not is_plugin_workspace_excluded(spec[1]))
      and spec_result
      and module_result
      and mode_result
  end

  return spec
end

local function source_local_config()
  local workspace = require "dotfiles.workspace"

  workspace["source-local-config"]({all = true})
end

local function startup()
  load_lazy()
  bootstrap()
  source_local_config()

  local plugins = require "plugins"
  local specs = {}

  for _, spec in ipairs(plugins) do
    table.insert(specs, make_module_spec(spec))
  end

  require "lazy".setup(specs)
  require "dotfiles.bootstrap"
end

return {
  startup = startup,
  is_plugin_workspace_excluded = is_plugin_workspace_excluded
}

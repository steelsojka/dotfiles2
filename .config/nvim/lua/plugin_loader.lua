local function load_lib(package_name, clone_url, branch)
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/" .. package_name

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd(string.format("!git clone -b %s %s %s", branch, clone_url, install_path))
  end

  vim.cmd("packadd " .. package_name)
end

local function load_module(module_path)
  local module_name = string.gsub(module_path, "/", ".")

  if not package.loaded[module_name] then
    pcall(require, module_path)
  end

  return package.loaded[module_name]
end

local function load_plugin_module(name)
  return load_module("dotfiles/module/plugin/" .. name)
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

local function load_all_configs()
  local utils = load_module("dotfiles/util")
  local config_path = vim.fn.stdpath "config"
  local glob = config_path .. "/lua/dotfiles/module/plugin/*.lua"

  local file_paths = utils.glob(glob)
  local plugin_modules = {}

  for _, file_path in ipairs(file_paths) do
    local module_name = strip_extensions(vim.fn.fnamemodify(file_path, ":t"))

    plugin_modules[module_name] = load_plugin_module(module_name)
  end

  return plugin_modules
end

local function bootstrap()
  pcall(require, "impatient")

  -- Uncomment for profiling startup time
  --[[ pcall(function()
    require "impatient".enable_profile()
  end) ]]

  load_lib("packer.nvim", "https://github.com/wbthomason/packer.nvim", "master")
  load_lib("aniseed", "https://github.com/Olical/aniseed", "v3.24.0")

  -- Compile all fennel before we do anything...
  -- Note, don't load anything... just compile.
  require "aniseed.env".init({module = "dotfiles"})
end

-- Plugin modules are associated by the plugin name MINUS any extensions.
-- So, pears.nvim would become just "pears".
local function make_module_spec(spec, plugin_modules)
  if type(spec) == "string" then
    spec = {spec}
  end

  local spec_name = spec.alias or strip_extensions(vim.fn.fnamemodify(spec[1], ":t"))
  local spec_module = plugin_modules[spec_name]

  if not spec_module then
    return spec, nil
  end

  if type(spec_module.configure) == "function" then
    local module_name = string.format(
      "dotfiles.module.plugin.%s",
      strip_extensions(spec_name)
    )

    spec.config = string.format([[require("plugin_loader").configure_plugin("%s")]], module_name)
  end

  if spec_module.run then
    spec.run = spec_module.run
  end

  return spec, spec_module
end

local function source_local_config()
  local workspace = require "dotfiles.workspace"

  workspace["source-local-config"]({all = true})
end

local function get_workspace_excluded_plugins()
  local utils = require "dotfiles.util"

  return utils["get-var"]("packer_excluded_plugins") or {}
end

local function configure_plugin(plugin_path)
  local excluded_plugins = get_workspace_excluded_plugins()

  if not vim.tbl_contains(excluded_plugins) then
    require(plugin_path).configure()
  end
end

local function is_plugin_workspace_excluded(plugin)
  local excluded_plugins = get_workspace_excluded_plugins()

  return vim.tbl_contains(excluded_plugins, plugin)
end

local function startup()
  -- Load packer and compile fennel.
  bootstrap()
  source_local_config()

  local packer = require "packer"

  packer.init({
    compile_path = string.format("%s/%s/%s", vim.fn.stdpath('config'), 'lua', 'packer_compiled.lua'),
    display = {
      open_fn = require "packer.util".float
    }
  })
  packer.reset()

  local plugins = require "plugins"

  -- Read all plugin modules.
  local plugin_modules = load_all_configs()

  for _, spec in ipairs(plugins) do
    local normalized_spec, spec_module = make_module_spec(spec, plugin_modules)

    if spec_module then
      -- Run setup before we load the plugin.
      if spec_module.setup then
        spec_module.setup()
      end
    end

    packer.use(normalized_spec)
  end

  require "packer_compiled"
  require "dotfiles.bootstrap"
end

return {
  startup = startup,
  configure_plugin = configure_plugin,
  is_plugin_workspace_excluded = is_plugin_workspace_excluded
}

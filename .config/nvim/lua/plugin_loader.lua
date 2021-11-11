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
    require(module_path)
  end

  return package.loaded[module_name]
end

local function load_plugin_module(name)
  return load_module("dotfiles/module/plugin/" .. name)
end

local function load_all_configs()
  local utils = load_module("dotfiles/util")
  local config_path = vim.fn.stdpath "config"
  local glob = config_path .. "/lua/dotfiles/module/plugin/*.lua"

  local file_paths = utils.glob(glob)
  local plugin_modules = {}

  for _, file_path in ipairs(file_paths) do
    local module_name = vim.fn.fnamemodify(file_path, ":t:r")

    plugin_modules[module_name] = load_plugin_module(module_name)
  end

  return plugin_modules
end

local function bootstrap()
  load_lib("packer.nvim", "https://github.com/wbthomason/packer.nvim", "master")
  load_lib("aniseed", "https://github.com/Olical/aniseed", "v3.24.0")

  require "aniseed.env".init({module = "dotfiles"})
end


local function setup(startup)
  bootstrap()

  require "packer".startup({
    startup,
    config = {
      display = {
        open_fn = require "packer.util".float
      }
    }
  })

  local plugin_modules = load_all_configs()

  for _, plugin_mod in pairs(plugin_modules) do
    if type(plugin_mod.setup) == "function" then
      plugin_mod.setup()
    end
  end

  require "dotfiles.bootstrap"
end

local function make_lifecycle(lifecycle)
  return function(name, ...)
    local mod = load_plugin_module(name)

    if mod[lifecycle] then
      mod[lifecycle](...)
    end
  end
end

return {
  setup = setup,
  configure = make_lifecycle("configure")
}

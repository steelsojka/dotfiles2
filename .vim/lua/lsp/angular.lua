local lsp_configs = require 'nvim_lsp/configs'
local lsp_util = require 'nvim_lsp/util'

local server_name = 'angularls'
local bin_name = server_name
local install_loc = lsp_util.base_install_dir .. '/' .. server_name
local script_loc = install_loc .. '/node_modules/@angular/language-server/index.js'
local bin_loc = install_loc .. '/node_modules/.bin/angularls'

local installer = lsp_util.npm_installer {
  server_name = server_name;
  packages = { '@angular/language-server' };
  binaries = { 'angularls' };
  -- angular-language-service doesn't expose a binary, so we create an execution wrapper.
  post_install_script = 
    'echo "#! /bin/sh\n' .. 'node ' .. script_loc .. ' \\$*' .. '" > ' .. bin_loc .. '\n' ..
    'chmod +x ' .. bin_loc
}


local function get_probe_dir(root_dir)
  local project_root = lsp_util.find_node_modules_ancestor(root_dir)

  return project_root and (project_root .. '/node_modules') or ''
end

local default_prob_dir = get_probe_dir(vim.fn.getcwd())

lsp_configs[server_name] = {
  default_config = lsp_util.utf8_config {
    cmd = {
      bin_loc, 
      '--stdio',
      '--tsProbeLocations', default_prob_dir,
      '--ngProbeLocations', default_prob_dir
    };
    on_init= function(params, config)
      print(vim.inspect(params, config))
    end;
    filetypes = {'typescript', 'html', 'typescriptreact', 'typescript.tsx'};
    root_dir = lsp_util.root_pattern('angular.json', 'tsconfig.json', 'package.json', '.git');
    on_new_config = function(new_config)
      local install_info = installer.info()
      local new_prob_dir = get_probe_dir(new_config.root_dir)

      if install_info.is_installed then
        -- We need to check our probe directories because they may have changed.
        new_config.cmd = {
          bin_loc, 
          '--stdio',
          '--tsProbeLocations', new_prob_dir,
          '--ngProbeLocations', new_prob_dir
        }
      end
    end;
  };
  docs = {
    description = [[
https://github.com/angular/vscode-ng-language-service

`angular-language-server` can be installed via `:LspInstall angularls`

If you prefer to install this yourself you can through npm `npm install @angular/language-server`.
Be aware there is no global binary and must be run via `node_modules/@angular/language-server/index.js`
    ]];
    default_config = {
      root_dir = [[root_pattern("angular.json", "tsconfig.json", "package.json", ".git")]],
      on_init = [[function to handle changing offsetEncoding]],
      capabilities = [[default capabilities, with offsetEncoding utf-8]]
    };
  };
}

lsp_configs[server_name].install = installer.install
lsp_configs[server_name].install_info = installer.info

-- Global api

local api_paths = {
  buf = 'steelvim/buffers';
  common = 'steelvim/common';
  diagnostics = 'steelvim/diagnostics';
  files = 'steelvim/files';
  git = 'steelvim/git';
  grep = 'steelvim/grep';
  lsp = {
    'steelvim/lsp/utils',
    'steelvim/lsp/setup_config',
    'steelvim/lsp/callbacks'
  };
  qf = 'steelvim/quickfix';
  term = 'steelvim/terminal';
  wk = 'steelvim/which_key';
  mappings = 'steelvim/utils/mappings';
  utils = {
    unique_id = 'steelvim/utils/unique_id';
    funcref = 'steelvim/utils/funcref';
    jobs = 'steelvim/utils/jobs';
  };
  fn = 'steelvim/utils/utils';
  ansi = 'steelvim/ansi';
  win = 'steelvim/win';
  rx = {
    observable = 'steelvim/utils/observable';
    subscriber = 'steelvim/utils/subscriber';
    subscription = 'steelvim/utils/subscription';
  };
  project = 'steelvim/utils/project';
  fzf = 'steelvim/fzf';
  fs = 'steelvim/utils/fs';
}

local function setup_lookup_table(tbl, api, path)
  setmetatable(tbl, {
    __index = function(tbl, key)
      local api_path = api[key]
      local existing_api = rawget(tbl, key)

      if existing_api then return existing_api end

      if type(api_path) == 'table' then
        -- If a list then merge all modules into a single api
        if vim.tbl_islist(api_path) then
          local result = {}

          for _,path in ipairs(api_path) do
            result = vim.tbl_extend('force', result, require(path))
          end

          rawset(tbl, key, result)

          return result
        -- If a table then return the namespace that can lazily be looked up
        else
          local sub = {}

          rawset(tbl, key, sub)

          return setup_lookup_table(sub, api_path, path .. '.' .. key)
        end
      -- If a string then import that module
      elseif type(api_path) == 'string' then
        rawset(tbl, key, require(api_path))

        return rawget(tbl, key)
      else
        error("Could not find steel API path " .. path .. '.' .. key)
      end
    end
  })

  return tbl
end

-- Everything is exposed, lazily, as `steel`
steel = {
  -- Shorthand for commands
  command = vim.api.nvim_command;
  -- Easy way to expose nvim commands
  ex = setmetatable({}, {
    __index = function(tbl, key)
      local existing = rawget(tbl, key)

      if existing then return existing end

      local fn = function(...)
        local cmd = key

        for i = 1, select("#", ...) do
          cmd = cmd .. " " .. select(i, ...)
        end

        return vim.api.nvim_command(cmd)
      end

      rawset(tbl, key, fn)

      return fn
    end
  })
}

setup_lookup_table(steel, api_paths, 'steel')

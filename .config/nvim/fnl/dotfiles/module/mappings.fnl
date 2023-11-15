(module dotfiles.module.mappings
  {require {nvim aniseed.nvim
            util dotfiles.util
            buffers dotfiles.buffers
            ws dotfiles.workspace
            term dotfiles.terminal
            tele dotfiles.telescope
            qf dotfiles.quickfix
            keymap dotfiles.keymap
            sessions dotfiles.sessions
            rest-client dotfiles.rest-client
            lsp-logging dotfiles.lsp.logging
            repl dotfiles.repl
            lib dotfiles.lib
            browser dotfiles.browser}})

(keymap.register-mappings
   {"/" {:name "+local-search"}
    :s {:name "+search"}
    :f {:name "+file"}
    :b {:name "+buffers"}
    :w {:name "+windows" }
    :wb {:name "+balance"}
    :wt {:name "+terminal"}
    :y {:name "+yank"}
    :i {:name "+insert"}
    :g {:name "+git"}
    :gc {:name "+chunk"}
    :gf {:name "+file"}
    :p {:name "+project"}
    :ps {:name "+session"}
    :h {:name "+help"}
    :x {:name "+diagnostics"}
    :e {:name "explorer"}
    :l {:name "+quickfix"}
    :L {:name "+location"}
    :c {:name "+code"}
    :cc {:name "+case"}
    :ccp "PascalCase"
    :ccm "MixedCase"
    :ccc "camelCase"
    :ccu "UPPER CASE"
    :ccU "UPPER CASE"
    :cct "Title Case"
    :ccs "Sentence case"
    "cc_" "snake_case"
    :cck "kebab-case"
    "cc-" "dash-case"
    "cc " "space case"
    "cc." "dot.case"
    ; Locals need to be defined per filetype
    :m {:name "+local"}
    :d {:name "+debug"}
    :j {:name "+jump"}
    :jm {:name "+marks"}
    :jc {:name "+changes"}
    :je {:name "+errors"}
    :jq {:name "+quickfix"}
    :t {:name "+toggle"}
    :tb {:name "+buffer"}
    :r {:name "+REPL"}
    :o {:name "+Org"}}
   {:mode ["n" "v"] :prefix "<leader>"})

(keymap.register-mappings
  {"," {:do ":" :description "Ex"}
   "." {:do #(tele.find-files) :description "Find files"}
   "<CR>" {:do #(lib.telescope_builtin.marks) :description "Jump to mark"}
   "<leader>" {:do #(lib.telescope_builtin.commands) :description "Ex commands"}
   "\"" {:do "q:" :description "Ex History"}
   "fs" {:do "<Cmd>w<CR>" :description "Save file"}
   "fS" {:do "<Cmd>wa<CR>" :description "Save all files"}
   "f/" {:do #(lib.telescope_builtin.current_buffer_fuzzy_find) :description "Search lines"}
   "ff" {:do "<Cmd>Format<CR>" :description "Format file"}
   "fo" {:do "<Cmd>Oil %:p:h<CR>" :description "Show in tree"}
   "fO" {:do "<Cmd>Oil --float %:p:h<CR>" :description "Show in float tree"}
   "fr" {:do #(lib.telescope_builtin.oldfiles) :description "Open recent files"}
   "fu" {:do "<Cmd>UndotreeToggle<CR>" :description "Undo tree"}
   "fU" {:do "<Cmd>UndotreeFocus<CR>" :description "Focus undo tree"}
   "fE" {:do "<Cmd>vsp $MYVIMRC<CR>" :description "Edit .vimrc"}
   "fF" {:do #(tele.find-files {:cwd (vim.fn.expand "%:p:h")}) :description "Find from file"}
   "fP" {:do #(tele.find-files {:cwd "~/.vim/fnl"}) :description "Find config file"}
   ; Buffer mappings <leader>b
   "bp" {:do "<Cmd>bprevious<CR>" :description "Previous buffer"}
   "bn" {:do "<Cmd>bnext<CR>" :description "Next buffer"}
   "bf" {:do "<Cmd>bfirst<CR>" :description "First buffer"}
   "bl" {:do "<Cmd>blast<CR>" :description "Last buffer"}
   "bd" {:do "<Cmd>bp<CR>:bd#<CR>" :description "Delete buffer"}
   "bk" {:do "<Cmd>bp<CR>:bw!#<CR>" :description "Wipe buffer"}
   "bb" {:do #(tele.buffers) :description "List buffers"}
   "bY" {:do "ggyG" :description "Yank buffer"}
   "bm" {:do #(util.prompt-command :mark "Set mark") :description "Set mark"}
   ; Window mappings <leader>w
   "ww" {:do "<C-W>w" :description "Move below/right"}
   "wd" {:do "<C-W>c" :description "Delete window"}
   "ws" {:do "<C-W>s" :description "Split window"}
   "wv" {:do "<C-W>v" :description "Split window vertical"}
   "wn" {:do "<C-W>n" :description "New window"}
   "wq" {:do "<C-W>q" :description "Quit window"}
   "wj" {:do "<C-W>j" :description "Move down"}
   "wk" {:do "<C-W>k" :description "Move up"}
   "wh" {:do "<C-W>h" :description "Move left"}
   "wl" {:do "<C-W>l" :description "Move right"}
   "wJ" {:do "<C-W>J" :description "Move window down"}
   "wK" {:do "<C-W>K" :description "Move window up"}
   "wH" {:do "<C-W>H" :description "Move window left"}
   "wL" {:do "<C-W>L" :description "Move window right"}
   "wr" {:do "<C-W>r" :description "Rotate forward"}
   "wR" {:do "<C-W>R" :description "Rotate backwards"}
   "wbj" {:do "<Cmd>resize -5<CR>" :description "Shrink"}
   "wbk" {:do "<Cmd>resize +5<CR>" :description "Grow"}
   "wbl" {:do "<Cmd>vertical resize +5<CR>" :description "Vertical grow"}
   "wbh" {:do "<Cmd>vertical resize -5<CR>" :description "Vertical shrink"}
   "wbJ" {:do "<Cmd>resize -20<CR>" :description "Shrink large"}
   "wbK" {:do "<Cmd>resize +20<CR>" :description "Grow large"}
   "wbL" {:do "<Cmd>vertical resize +20<CR>" :description "Vertical grow large"}
   "wbH" {:do "<Cmd>vertical resize -20<CR>" :description "Vertical shrink large"}
   "wb=" {:do "<C-W>=" :description "Balance splits"}
   "w=" {:do "<C-W>=" :description "Balance splits"}
   "wF" {:do "<Cmd>tabnew<CR>" :description "New tab"}
   "wo" {:do "<Cmd>tabnext<CR>" :description "Next tab"}
   ; Project mappings <leader>p
   "ph" {:do #(lib.telescope_builtin.oldfiles) :description "MRU"}
   "pf" {:do #(tele.find-files {:cwd (vim.fn.getcwd)}) :description "Find file"}
   "pss" {:do #(sessions.save-session) :description "Save (default)"}
   "psS" {:do #(sessions.save-session nil true) :description "Save"}
   "psl" {:do #(sessions.load-session true) :description "Load (default)"}
   "psL" {:do #(sessions.load-session false) :description "Load"}
   "psc" {:do "<Cmd>SClose<CR>" :description "Project session close"}
   "psd" {:do #(sessions.delete-session true) :description "Delete (default)"}
   "psD" {:do #(sessions.delete-session) :description "Delete"}
   "pT" {:do "<Cmd>Oil --float<CR>" :description "Open File explorer in float"}
   "pt" {:do "<Cmd>Oil<CR>" :description "Open file Explorer"}
   "pq" {:do "<Cmd>qall<CR>" :description "Quit project"}
   "pQ" {:do "<Cmd>qall!<CR>" :description "Quit project force"}
   "pc" {:do #(ws.cd-to-root) :description "Cwd to root"}
   ; Workspace mappings <leader>q
   "q" {:do #(vim.cmd "q") :description "Quit"}
   "Q" {:do #(vim.cmd "q!") :description "Force quit"}
   ; Navigation mappings <leader>j
   "jl" {:do "$" :description "End of line"}
   "jh" {:do "0" :description "Start of line"}
   "jk" {:do "<C-b>" :description "Page up"}
   "jj" {:do "<C-f>" :description "Page down"}
   "jd" {:do #(vim.lsp.buf.definition) :description "Definition"}
   "ji" {:do #(vim.lsp.buf.implementation) :description "Implementation"}
   "jy" {:do #(vim.lsp.buf.type_definition) :description "Type definition"}
   "js" {:do #(lib.telescope_builtin.lsp_document_symbols) :description "Jump to symbol"}
   "jS" {:do #(lib.telescope_builtin.lsp_workspace_symbols) :description "Jump to symbol in workspace"}
   "jr" {:do #(lib.telescope_builtin.lsp_references) :description "Type references"}
   "jep" {:do #(vim.diagnostic.goto_prev {:severity vim.lsp.protocol.DiagnosticSeverity.Error}) :description "Previous error"}
   "jen" {:do #(vim.diagnostic.goto_next {:severity vim.lsp.protocol.DiagnosticSeverity.Error}) :description "Next error"}
   "jeN" {:do #(vim.diagnostic.goto_next) :description "Next diagnostic"}
   "jeP" {:do #(vim.diagnostic.goto_prev) :description "Previous diagnostic"}
   "jqp" {:do "<Cmd>cN<CR>" :description "Previous"}
   "jqn" {:do "<Cmd>cn<CR>" :description "Next"}
   "jn" {:do "<C-o>" :description "Next jump"}
   "jp" {:do "<C-i>" :description "Previous jump"}
   "jml" {:do #(lib.telescope_builtin.marks) :description "List marks"}
   "jmd" {:do ":delmarks<Space>" :description "Delete marks"}
   "jmm" {:do "`" :description "Go to mark"}
   "jcn" {:do "g," :description "Next change"}
   "jcp" {:do "g;" :description "Previous change"}
   ; Insert mappings <leader>i
   "if" {:do "\"%p" :description "Current file name"}
   "iF" {:do "<Cmd>put expand(\"%:p\")<CR>" :description "Current file path"}
   "is" {:do #(lib.telescope.extensions.snippets.snippets) :description "Insert snippet"}
   "ir" {:do #(tele.insert-relative-path (vim.fn.expand "%:p:h")) :description "Insert relative path"}
   "ip" {:do #(tele.complete-path) :description "Insert path"}
   ; Search mappings <leader>s
   "sd" {:do #(tele.live-grep {:cwd (vim.fn.expand "%:h")}) :description "Grep files in directory"}
   "sc" {:do #(lib.telescope_builtin.command_history) :description "Search command history"}
   "si" {:do #(lib.telescope_builtin.lsp_workspace_symbols) :description "Search symbol"}
   "sb" {:do #(lib.telescope_builtin.current_buffer_fuzzy_find) :description "Search buffer"}
   "ss" {:do #(lib.spectre.open_file_search {:select_word true}) :description "Search/Replace in file (selected)"}
   "so" {:do #(lib.telescope_builtin.lsp_document_symbols) :description "List symbols in file"}
   "sp" {:do #(tele.live-grep) :description "Grep files in project"}
   "sm" {:do #(lib.telescope_builtin.marks) :description "Jump to marks"}
   "sw" {:do #(lib.telescope_builtin.spell_suggest) :description "Spell suggest"}
   "sS" {:do #(tele.grep-string) :description "Search selected text (project)"}
   "sr" {:do #(lib.spectre.toggle) :description "Search/Replace (project)"}
   "sR" {:do #(lib.spectre.open_file_search) :description "Search/Replace (file)"}
   ; Local Search/Replace mappings <leader>/
   "/h" {:do "<Cmd>noh<CR>" :description "Clear searh highlight"}
   "/s" {:do "g*N" :description "Search selected text"}
   "/r" {:do #(do (nvim.ex.normal "g*") (nvim.input ":%s//")) :description "Replace selected text"}
   ; Yank with preview <leader>y
   "yf" {:do "<Cmd>let @\" expand(\"%:p\")<CR>" :description "Yank file path"}
   "yF" {:do "<Cmd>let @\" expand(\"%:t:r\")<CR>" :description "Yank file name"}
   "yy" {:do "\"+y" :description "Yank to clipboard"}
   ; Diagnostic mappings <leader>x
   "xx" {:do "<Cmd>TroubleToggle<CR>" :description "Toggle"}
   "xw" {:do "<Cmd>TroubleToggle lsp_workspace_diagnostics<CR>" :description "Toggle workspace"}
   "xd" {:do "<Cmd>TroubleToggle lsp_document_diagnostics<CR>" :description "Toggle document"}
   "xq" {:do "<Cmd>TroubleToggle quickfix<CR>" :description "Toggle quickfix"}
   "xl" {:do "<Cmd>TroubleToggle loclist<CR>" :description "Toggle location"}
   ; Code mappings <leader>c
   "cl" {:do "<Plug>kommentary_line_default<C-c>" :description "Comment line"}
   "cW" {:do (string.format "<Cmd>vsp term://tail -f -n100 %s | normal! G<CR>" (vim.lsp.get_log_path)) :description "Watch LSP Log"}
   "cd" {:do #(vim.lsp.buf.definition) :description "Definition"}
   "cD" {:do #(lib.telescope_builtin.lsp_references) :description "Type references"}
   "ck" {:do "gh" :description "Jump to documentation" :noremap false}
   "cr" {:do #(vim.lsp.buf.rename) :description "LSP rename"}
   "ce" {:do #(vim.diagnostic.set_loclist) :description "List errors"}
   "cR" {:do "<Cmd>LspRestart<CR>" :description "LSP reload"}
   "cs" {:do #(vim.lsp.buf.signature_help) :description "Signature help"}
   "cj" {:do #(lib.telescope_builtin.lsp_document_symbols) :description "Jump to symbol"}
   "cJ" {:do #(lib.telescope_builtin.lsp_workspace_symbols) :description "Jump to symbol in workspace"}
   "ca" {:do #(vim.lsp.buf.code_action) :description "LSP code actions"}
   "co" {:do "<Cmd>AerialOpen<CR>" :description "Open outline"}
   "cO" {:do "<Cmd>AerialNavOpen<CR>" :description "Open outline (nav)"}
   "lk" {:do "<Cmd>cN<CR>" :description "Previous"}
   "lj" {:do "<Cmd>cn<CR>" :description "Next"}
   "Lk" {:do "<Cmd>lN<CR>" :description "Previous"}
   "Lj" {:do "<Cmd>lne<CR>" :description "Next"}
   "lo" {:do "<Cmd>copen<CR>" :description "Open"}
   "Lo" {:do "<Cmd>lopen<CR>" :description "Open"}
   "lO" {:do "<Cmd>cclose<CR>" :description "Close"}
   "LO" {:do "<Cmd>lclose<CR>" :description "Close"}
   "ll" {:do #(let [line (. (nvim.fn.getpos ".") 2)]
                   (qf.add-item (- line 1) line))
            :description "Add line to quickfix"}
   "Ll" {:do #(let [line (. (nvim.fn.getpos ".") 2)]
                   (qf.add-item (- line 1) line {:loc true}))
            :description "Add line to location"}
   "ln" {:do #(qf.new-list) :description "New quickfix list"}
   "Ln" {:do #(qf.new-list {:loc true}) :description "New loc list"}
   "cH" {:do #(lsp-logging.set-logging-level) :description "Set LSP log level"}
   ; Git mappings <leader>g
   "gcu" {:do #(lib.gitsigns.reset_hunk) :description "Undo chunk"}
   "gcs" {:do #(lib.gitsigns.stage_hunk) :description "Stage chunk"}
   "gcS" {:do #(lib.gitsigns.undo_stage_hunk) :description "Unstage chunk"}
   "gcn" {:do #(lib.gitsigns.next_hunk) :description "Next chunk"}
   "gcp" {:do #(lib.gitsigns.prev_hunk) :description "Previous chunk"}
   "gci" {:do #(lib.gitsigns.preview_hunk) :description "Chunk info"}
   "gcb" {:do #(lib.gitsigns.blame_line) :description "Chunk blame"}
   "gB" {:do #(lib.telescope_builtin.git_branches) :description "Checkout branch"}
   "gs" {:do #(lib.telescope_builtin.git_status) :description "Git status"}
   "gd" {:do "<Cmd>DiffviewOpen<CR>" :description "Git diff"}
   "gg" {:do #(lib.neogit.open) :description "Git GUI"}
   "gfh" {:do "<Cmd>DiffviewFileHistory %<CR>" :description "Git File History"}
   "gl" {:do #(lib.neogit.open ["log"]) :description "Git log"}
   "gL" {:do #(lib.telescope_builtin.git_bcommits) :description "Git file log"}
   "gb" {:do "<Cmd>ToggleBlame virtual<CR>" :description "Git blame"}
   "gC" {:do #(lib.telescope_builtin.git_commits) :description "Find commit"}
   "gF" {:do #(lib.telescope_builtin.git_files) :description "Find file"}
   ; Terminal mappings <leader>wt
   "wtt" {:do #(term.open) :description "Terminal"}
   "wtv" {:do #(do (nvim.ex.vsp) (term.open)) :description "Vertical split terminal"}
   "wtf" {:do #(do (nvim.ex.vsp) (term.open true)) :description "Terminal at file"}
   ; Toggle mappings <leader>t
   "tl" {:do "<Cmd>set number!<CR>" :description "Line numbers"}
   "tw" {:do "<Cmd>set wrap!<CR>" :description "Word wrap"}
   "tW" {:do #(buffers.toggle-trim-trailing-ws) :description "Trim trailing whitespace"}
   "tr" {:do "<Cmd>set modifiable!<CR>" :description "Read only"}
   "ts" {:do "<Cmd>set spell!<CR>" :description "Spell check"}
   "tc" {:do "<Cmd>set list!<CR>" :description "Whitespace Chars"}
   "tf" {:do "za" :description "Fold"}
   "tF" {:do "zA" :description "Fold recursively"}
   "te" {:do #(keymap.unimplemented) :description "Inline errors"}
   "tbr" {:do #(rest-client.toggle-rest-buf) :description "Toggle REST Client"}
   ; Help mappings <leader>h
   "hh" {:do #(lib.telescope_builtin.help_tags) :description "Help tags"}
   "hi" {:do #(lib.telescope_builtin.highlights) :description "List highlights"}
   "hm" {:do #(lib.telescope_builtin.man_pages) :description "Man pages"}
   "ho" {:do #(lib.telescope_builtin.vim_options) :description "Vim options"}
   "ha" {:do #(lib.telescope_builtin.autocommands) :description "List autocommands"}
   "hk" {:do #(lib.telescope_builtin.keymaps) :description "List keymaps"}
   "hl" {:do "<Cmd>Mason<CR>" :description "List LSP"}
   "hp" {:do "<Cmd>Lazy<CR>" :description "List Plugins"}
   ; Debug mappings <leader>d
   "db" {:do #(lib.dap.toggle_breakpoint) :description "Toggle breakpoint"}
   "dc" {:do #(lib.dap.continue) :description "Continue"}
   "ds" {:do #(lib.dap.step_into) :description "Step into"}
   "dS" {:do #(lib.dap.step_over) :description "Step over"}
   "dr" {:do #(lib.dap.repl.open) :description "REPL"}
   "dh" {:do #(lib.dap_ui_widgets.hover) :description "Inspect variable"}
   ; REPL
   "ro" {:do #(repl.open-repl) :description "Open REPL"}
   "rO" {:do #(repl.select-repl) :description "Select REPL"}
   "re" {:do #(repl.eval-line) :description "Eval line"}
   "rf" {:do #(repl.eval-file) :description "Eval file"}
   "rk" {:do #(repl.kill) :description "Kill REPL"}
   "rR" {:do #(repl.reset) :description "Reset REPL"}
   ; Web explorer
   "es" {:do #(browser.prompt-search) :description "Search term"}
   "eS" {:do #(browser.prompt-search true) :description "Search term (ext)"}}
  {:mode "n" :prefix "<leader>"})

; Non-leader mappings
(keymap.register-mappings
  {";" {:do ":" :description "Ex command mode"}
   "jj" {:do "<esc>" :description "Exit insert mode" :mode "i"}
   "<C-j><C-j>" {:do "<C-\\><C-n>" :description "Exit terminal mode" :mode "t"}
   "U" {:do "<C-r>" :description "Redo"}
   "/" {:do "/\\v" :description "Search with magic"}
   "?" {:do "?\\v" :description "Search backwards with magic"}
   "K" {:do #(util.show-documentation false) :description "Show documentation"}
   "gh" {:do #(util.show-documentation true) :description "Show documentation"}
   "<C-e>" {:do #(tele.complete-path) :description "Complete path" :mode "i"}
   "<C-w>" {:do #(tele.insert-word) :description "Insert word" :mode "i"}
   "F" {:do "<Cmd>HopChar2<CR>" :description "Hop 2 chars"}
   "f" {:do "<Cmd>HopChar1<CR>" :description "Hop 1 chars"}
   "s" {:do "<Cmd>HopWord<CR>" :description "Hop word"}
   "S" {:do "<Cmd>HopPattern<CR>" :description "Hop pattern"}}
   {:mode "n"})

; Visual leader mappings
(keymap.register-mappings
  {"jl" {:do "$" :description "End of line" }
   "jh" {:do "0" :description "Start of line" }
   "jk" {:do "<C-b>" :description "Page up" }
   "jj" {:do "<C-f>" :description "Page down" }
   "/s" {:do "9y/<C-r>9<CR>" :description "Search selected text"}
   "/S" {:do "9y:Rg <C-r>9<CR>" :description "Search selected text"}
   "yy" {:do "\"+y" :description "Yank selected text to cb"}
   "cl" {:do "<Plug>kommentary_visual_default" :description "Comment selected lines"}
   "ll" {:do #(qf.add-item
                   (- (. (vim.fn.getpos "'<") 2) 1) (. (vim.fn.getpos "'>") 2))
            :description "Add line to quickfix"}
   "Ll" {:do #(qf.add-item
                   (- (. (vim.fn.getpos "'<") 2) 1) (. (vim.fn.getpos "'>") 2) {:loc true})
            :description "Add line to location"}
   "dH" {:do #(dap-widgets.hover) :description "Inspect variable (visual)"}
   "re" {:do #(repl.eval-line-visual) :description "Eval selection"}
   "es" {:do #(browser.search (let [lines (buffers.get-visual-selection)]
                                  (table.concat lines))) :description "Search term"}
   "eS" {:do #(browser.search (let [lines (buffers.get-visual-selection)]
                                  (table.concat lines))
                                nil
                                true) :description "Search term (ext)"}
   "sr" {:do #(lib.spectre.open_visual) :description "Search/Replace in file (selected)"}}
   {:mode "v" :prefix "<leader>"})

; Non-leader visual mappings
(keymap.register-mappings
  {"F" {:do "<Cmd>HopChar2<CR>" :description "Hop 2 chars"}
   "f" {:do "<Cmd>HopChar1<CR>" :description "Hop 1 chars"}
   "s" {:do "<Cmd>HopWord<CR>" :description "Hop word"}
   "S" {:do "<Cmd>HopPattern<CR>" :description "Hop pattern"}
   "\"" {:do "q:" :description "Ex History"}}
   {:mode "v"})

(module dotfiles.module.mappings
  {require {nvim aniseed.nvim
            which-key dotfiles.which-key
            files dotfiles.files
            util dotfiles.util
            buffers dotfiles.buffers
            ws dotfiles.workspace
            grep dotfiles.grep
            term dotfiles.terminal
            diagnostics dotfiles.diagnostics
            tele dotfiles.telescope
            qf dotfiles.quickfix
            keymap dotfiles.keymap}})

(local telescope (require "telescope.builtin"))
(local dap (require "dap"))
(local dap-variables (require "dap.ui.variables"))

(def- which-key-map {
  " " "Ex command"
  "/" {:name "+local-search"}
  :s {:name "+search"}
  :f {:name "+file"}
  :b {:name "+buffers"}
  :w {:name "+windows" :b {:name "+balance"} :t {:name "+terminal"}}
  :y {:name "+yank"}
  :i {:name "+insert"}
  :g {:name "+git" :c {:name "+chunk"} :f {:name "+find"}}
  :p {:name "+project"}
  :h {:name "+help"}
  :c {:name "+code"
      :q {:name "+quickfix"}
      :c {:name "+case"
          :p "PascalCase"
          :m "MixedCase"
          :c "camelCase"
          :u "UPPER CASE"
          :U "UPPER CASE"
          :t "Title Case"
          :s "Sentence case"
          "_" "snake_case"
          :k "kebab-case"
          "-" "dash-case"
          " " "space case"
          "." "dot.case"}}
   ; Locals need to be defined per filetype
  :m {:name "+local"}
  :d {:name "+debug"}
  :j {:name "+jump"
      :m {:name "+marks"}
      :c {:name "+changes"}
      :e {:name "+errors"}
      :q {:name "+quickfix"}}
  :t {:name "+toggle"
      :b {:name "+buffer"}}})

(keymap.register-mappings {
  "n " {:do #(which-key.start false) :silent true}
  "n;" {:do ":"}
  "v " {:do #(which-key.start true) :silent true}
  "i<C-Space>" {:do "compe#complete()" :silent true :expr true}
  "n <CR>" {:do #(telescope.marks) :description "Jump to mark"}
  "ijj" {:do "<esc>" :description "Exit insert mode"}
  "t<C-j><C-j>" {:do "<C-\\><C-n>" :description "Exit terminal mode"}
  "nU" {:do "<C-r>" :description "Redo"}
  "n/" {:do "/\\v" :description "Search with magic"}
  "n?" {:do "?\\v" :description "Search backwards with magic"}
  "nK" {:do #(util.show-documentation false) :silent true :description "Show documentation"}
  "ngh" {:do #(util.show-documentation true) :silent true :description "Show documentation"}
  "i<C-e>" {:do #(tele.complete-path)}
  "i<C-w>" {:do #(tele.insert-word)}
  "nf" {:do "<Plug>Sneak_f"}
  "nF" {:do "<Plug>Sneak_F"}
  "xf" {:do "<Plug>Sneak_f"}
  "xF" {:do "<Plug>Sneak_F"}
  "of" {:do "<Plug>Sneak_f"}
  "oF" {:do "<Plug>Sneak_F"}
  "nt" {:do "<Plug>Sneak_t"}
  "nT" {:do "<Plug>Sneak_T"}
  "xt" {:do "<Plug>Sneak_t"}
  "xT" {:do "<Plug>Sneak_T"}
  "ot" {:do "<Plug>Sneak_t"}
  "oT" {:do "<Plug>Sneak_T"}
  "n ," {:do #(tele.buffers) :description "Switch buffer"}
  "n ." {:do #(tele.find-files) :description "Find files"}
  "n  " {:do #(telescope.commands)}
  "n \"" {:do "q:" :description "Ex History"}
  "v \"" {:do "q:" :description "Ex History"}
  "n x" {:do "<Cmd>sp e<CR>" :description "Scratch buffer"}
  ; File mappings <leader>f
  "n fs" {:do "<Cmd>w<CR>" :description "Save file"}
  "n fS" {:do "<Cmd>wa<CR>" :description "Save all files"}
  "n f/" {:do #(telescope.current_buffer_fuzzy_find) :description "Search lines"}
  "n ff" {:do "<Cmd>Format<CR>" :description "Format file"}
  "n fo" {:do "<Cmd>Dirvish %:p:h<CR>" :description "Show in tree"}
  "n fO" {:do "<Cmd>vsp +Dirvish %:p:h<CR>" :description "Show in split tree"}
  "n fr" {:do #(telescope.oldfiles) :description "Open recent files"}
  "n fu" {:do "<Cmd>UndotreeToggle<CR>" :description "Undo tree"}
  "n fU" {:do "<Cmd>UndotreeFocus<CR>" :description "Focus undo tree"}
  "n fE" {:do "<Cmd>vsp $MYVIMRC<CR>" :description "Edit .vimrc"}
  "n fF" {:do #(tele.find-files {:cwd (vim.fn.expand "%:p:h")}) :description "Find from file"}
  "n fP" {:do #(tele.find-files {:cwd "~/.vim/fnl"}) :description "Find config file"}
  ; Buffer mappings <leader>b
  "n bp" {:do "<Cmd>bprevious<CR>" :description "Previous buffer"}
  "n bn" {:do "<Cmd>bnext<CR>" :description "Next buffer"}
  "n bf" {:do "<Cmd>bfirst<CR>" :description "First buffer"}
  "n bl" {:do "<Cmd>blast<CR>" :description "Last buffer"}
  "n bd" {:do "<Cmd>bp<CR>:bd#<CR>" :description "Delete buffer"}
  "n bk" {:do "<Cmd>bp<CR>:bw!#<CR>" :description "Wipe buffer"}
  "n bb" {:do #(tele.buffers) :description "List buffers"}
  "n bY" {:do "ggyG" :description "Yank buffer"}
  "n bm" {:do #(util.prompt-command :mark "Set mark") :description "Set mark"}
  ; Window mappings <leader>w
  "n ww" {:do "<C-W>w" :description "Move below/right"}
  "n wd" {:do "<C-W>c" :description "Delete window"}
  "n ws" {:do "<C-W>s" :description "Split window"}
  "n wv" {:do "<C-W>v" :description "Split window vertical"}
  "n wn" {:do "<C-W>n" :description "New window"}
  "n wq" {:do "<C-W>q" :description "Quit window"}
  "n wj" {:do "<C-W>j" :description "Move down"}
  "n wk" {:do "<C-W>k" :description "Move up"}
  "n wh" {:do "<C-W>h" :description "Move left"}
  "n wl" {:do "<C-W>l" :description "Move right"}
  "n wJ" {:do "<C-W>J" :description "Move window down"}
  "n wK" {:do "<C-W>K" :description "Move window up"}
  "n wH" {:do "<C-W>H" :description "Move window left"}
  "n wL" {:do "<C-W>L" :description "Move window right"}
  "n wr" {:do "<C-W>r" :description "Rotate forward"}
  "n wR" {:do "<C-W>R" :description "Rotate backwards"}
  "n wbj" {:do "<Cmd>resize -5<CR>" :description "Shrink"}
  "n wbk" {:do "<Cmd>resize +5<CR>" :description "Grow"}
  "n wbl" {:do "<Cmd>vertical resize +5<CR>" :description "Vertical grow"}
  "n wbh" {:do "<Cmd>vertical resize -5<CR>" :description "Vertical shrink"}
  "n wbJ" {:do "<Cmd>resize -20<CR>" :description "Shrink large"}
  "n wbK" {:do "<Cmd>resize +20<CR>" :description "Grow large"}
  "n wbL" {:do "<Cmd>vertical resize +20<CR>" :description "Vertical grow large"}
  "n wbH" {:do "<Cmd>vertical resize -20<CR>" :description "Vertical shrink large"}
  "n wb=" {:do "<C-W>=" :description "Balance splits"}
  "n w=" {:do "<C-W>=" :description "Balance splits"}
  "n wF" {:do "<Cmd>tabnew<CR>" :description "New tab"}
  "n wo" {:do "<Cmd>tabnext<CR>" :description "Next tab"}
  "n wS" {:do "<Cmd>Startify<CR>" :description "Start screen"}
  ; Project mappings <leader>p
  "n ph" {:do #(telescope.oldfiles) :description "MRU"}
  "n pf" {:do #(tele.find-files {:cwd (vim.fn.expand ".")}) :description "Find file"}
  "n ps" {:do #(telescope.grep_string) :description "Find file with text"}
  "n pT" {:do "<Cmd>vsp +Dirvish<CR>" :description "Open File explorer in split"}
  "n pt" {:do "<Cmd>Dirvish<CR>" :description "Open file Explorer"}
  "n pq" {:do "<Cmd>qall<CR>" :description "Quit project"}
  "n pc" {:do #(ws.cd-to-root) :description "Cwd to root"}
  ; Workspace mappings <leader>q
  "n q" {:do "<Cmd>q<CR>" :description "Quit"}
  "n Q" {:do "<Cmd>q!<CR>" :description "Force quit"}
  ; Navigation mappings <leader>j
  "n jl" {:do "$" :description "End of line"}
  "v jl" {:do "$" :description "End of line" :which-key false}
  "n jh" {:do "0" :description "Start of line"}
  "v jh" {:do "0" :description "Start of line" :which-key false}
  "n jk" {:do "<C-b>" :description "Page up"}
  "v jk" {:do "<C-b>" :description "Page up" :which-key false}
  "n jj" {:do "<C-f>" :description "Page down"}
  "v jj" {:do "<C-f>" :description "Page down" :which-key false}
  "n jd" {:do #(vim.lsp.buf.definition) :description "Definition"}
  "n ji" {:do #(vim.lsp.buf.implementation) :description "Implementation"}
  "n jy" {:do #(vim.lsp.buf.type_definition) :description "Type definition"}
  "n js" {:do #(telescope.lsp_document_symbols) :description "Jump to symbol"}
  "n jS" {:do #(telescope.lsp_workspace_symbols) :description "Jump to symbol in workspace"}
  "n jr" {:do #(telescope.lsp_references) :description "Type references"}
  "n jep" {:do #(vim.lsp.diagnostic.goto_prev {:severity vim.lsp.protocol.DiagnosticSeverity.Error}) :description "Previous error"}
  "n jen" {:do #(vim.lsp.diagnostic.goto_next {:severity vim.lsp.protocol.DiagnosticSeverity.Error}) :description "Next error"}
  "n jeN" {:do #(vim.lsp.diagnostic.goto_next) :description "Next diagnostic"}
  "n jeP" {:do #(vim.lsp.diagnostic.goto_prev) :description "Previous diagnostic"}
  "n jqp" {:do "<Cmd>cN<CR>" :description "Previous"}
  "n jqn" {:do "<Cmd>cn<CR>" :description "Next"}
  "n jn" {:do "<C-o>" :description "Next jump"}
  "n jp" {:do "<C-i>" :description "Previous jump"}
  "n jml" {:do #(telescope.marks) :description "List marks"}
  "n jmd" {:do ":delmarks<Space>" :description "Delete marks"}
  "n jmm" {:do "`" :description "Go to mark"}
  "n jcn" {:do "g," :description "Next change"}
  "n jcp" {:do "g;" :description "Previous change"}
  ; Insert mappings <leader>i
  "n if" {:do "\"%p" :description "Current file name"}
  "n iF" {:do "<Cmd>put expand(\"%:p\")<CR>" :description "Current file path"}
  "n is" {:do #(keymap.unimplemented) :description "Insert snippet"}
  "n ir" {:do #(tele.insert-relative-path (vim.fn.expand "%:p:h")) :description "Insert relative path"}
  "n ip" {:do #(tele.complete-path) :description "Insert path"}
  ; Search mappings <leader>s
  "n sd" {:do #(tele.live-grep {:cwd (vim.fn.expand "%:h")}) :description "Grep files in directory"}
  "n sc" {:do #(telescope.command_history) :description "Search command history"}
  ; "n sh" {:do "<Cmd>History/<CR>" :description "Search history"}
  "n si" {:do #(telescope.lsp_workspace_symbols) :description "Search symbol"}
  "n sb" {:do #(telescope.current_buffer_fuzzy_find) :description "Search buffer"}
  "n ss" {:do #(telescope.current_buffer_fuzzy_find) :description "Search buffer"}
  "n so" {:do #(telescope.lsp_document_symbols) :description "List symbols in file"}
  ; "n sl" {:do "<Cmd>Lines<CR>" :description "Search lines"}
  "n sp" {:do #(tele.live-grep) :description "Grep files in project"}
  "n sm" {:do #(telescope.marks) :description "Jump to marks"}
  ; "n sa" {:do #(grep.flygrep "" (nvim.fn.expand "%:p:h") 0 ["--hidden" "--no-ignore"]) :description "Grep all files"}
  "n sS" {:do #(tele.grep-string) :description "Search selected text (project)"}
  ; Local Search/Replace mappings <leader>/
  "n /h" {:do "<Cmd>noh<CR>" :description "Clear searh highlight"}
  "n /s" {:do "g*N" :description "Search selected text"}
  "v /s" {:do "9y/<C-r>9<CR>"}
  "v /S" {:do "9y:Rg <C-r>9<CR>"}
  "n /r" {:do #(do (nvim.ex.normal "g*") (nvim.input ":%s//")) :description "Replace selected text"}
  ; Yank with preview <leader>y
  "n yf" {:do "<Cmd>let @\" expand(\"%:p\")<CR>" :description "Yank file path"}
  "n yF" {:do "<Cmd>let @\" expand(\"%:t:r\")<CR>" :description "Yank file name"}
  "n yy" {:do "\"+y" :description "Yank to clipboard"}
  "v yy" {:do "\"+y"}
  ; Code mappings <leader>c
  "n cl" {:do "<Cmd>Commentary<CR>" :description "Comment line"}
  "v cl" {:do ":Commentary<CR>"}
  "n cx" {:do #(diagnostics.open-diagnostics {:bufnr (nvim.fn.bufnr "%")}) :description "Document diagnostics"}
  "n cX" {:do #(diagnostics.open-diagnostics) :description "Workspace diagnostics"}
  "n cd" {:do #(vim.lsp.buf.definition) :description "Definition"}
  "n cD" {:do #(telescope.lsp_references) :description "Type references"}
  "n ck" {:do "gh" :description "Jump to documentation" :noremap false}
  "n cr" {:do #(vim.lsp.buf.rename) :description "LSP rename"}
  "n ce" {:do #(vim.lsp.diagnostic.set_loclist) :description "List errors"}
  "n cR" {:do #(do
                 (-> (vim.lsp.get_active_clients)
                     (vim.lsp.stop_client))
                 (nvim.command "e!"))
          :description "LSP reload"}
  "n cs" {:do #(vim.lsp.buf.signature_help) :description "Signature help"}
  "n cj" {:do #(telescope.lsp_document_symbols) :description "Jump to symbol"}
  "n cJ" {:do #(telescope.lsp_workspace_symbols) :description "Jump to symbol in workspace"}
  "n ca" {:do #(telescope.lsp_code_actions) :description "LSP code actions"}
  "n cql" {:do #(let [line (. (nvim.fn.getpos ".") 2)]
                  (qf.add-item line line))
           :description "Add line to quickfix"}
  "v cql" {:do #(qf.add-item
                  (. (vim.fn.getpos "'<") 2) (. (vim.fn.getpos "'>") 2))
           :description "Add line to quickfix"}
  "n cqn" {:do #(qf.new-list) :description "New quickfix list"}
  ; Git mappings <leader>g
  "n gcu" {:do "<Cmd>GitGutterUndoHunk<CR>" :description "Undo chunk"}
  "n gcs" {:do "<Cmd>GitGutterStageHunk<CR>" :description "Stage chunk"}
  "n gcn" {:do "<Cmd>GitGutterNextHunk<CR>" :description "Next chunk"}
  "n gcp" {:do "<Cmd>GitGutterPrevHunk<CR>" :description "Previous chunk"}
  "n gci" {:do "<Cmd>GitGutterPreviewHunk<CR>" :description "Chunk info"}
  "n gB" {:do #(telescope.git_branches) :description "Checkout branch"}
  "n gs" {:do #(telescope.git_status) :description "Git status"}
  "n gd" {:do "<Cmd>Gdiffsplit<CR>" :description "Git diff"}
  "n ge" {:do "<Cmd>Gedit<CR>" :description "Git edit"}
  "n gg" {:do #(term.float-cmd "lazygit") :description "Git GUI"}
  "n gl" {:do #(telescope.git_commits) :description "Git log"}
  "n gL" {:do #(telescope.git_bcommits) :description "Git file log"}
  "n gF" {:do "<Cmd>Gfetch<CR>" :description "Git fetch"}
  "n gp" {:do "<Cmd>Gpull<CR>" :description "Git pull"}
  "n gP" {:do "<Cmd>Gpush<CR>" :description "Git push"}
  "n gb" {:do "<Cmd>Gblame<CR>" :description "Git blame"}
  "n gfc" {:do #(telescope.git_commits) :description "Find commit"}
  "n gff" {:do #(telescope.git_files) :description "Find file"}
  "n gfg" {:do #(keymap.unimplemented) :description "Find gitconfig file"}
  "n gfi" {:do #(keymap.unimplemented) :description "Find issue"}
  "n gfp" {:do #(keymap.unimplemented) :description "Find pull request"}
  ; Terminal mappings <leader>wt
  "n wtt" {:do #(term.open) :description "Terminal"}
  "n wtv" {:do #(do (nvim.ex.vsp) (term.open)) :description "Vertical split terminal"}
  "n wtf" {:do #(do (nvim.ex.vsp) (term.open true)) :description "Terminal at file"}
  ; Toggle mappings <leader>t
  "n tl" {:do #(keymap.unimplemented) :description "Line numbers"}
  "n tw" {:do "<Cmd>set wrap!<CR>" :description "Word wrap"}
  "n tr" {:do "<Cmd>set modifiable!<CR>" :description "Read only"}
  "n ts" {:do "<Cmd>set spell!<CR>" :description "Spell check"}
  "n tf" {:do "za" :description "Fold"}
  "n tF" {:do "zA" :description "Fold recursively"}
  "n te" {:do #(keymap.unimplemented) :description "Inline errors"}
  ; Help mappings <leader>h
  "n hh" {:do #(telescope.help_tags) :description "Help tags"}
  "n hi" {:do #(telescope.highlights) :description "List highlights"}
  "n hm" {:do #(telescope.man_pages) :description "Man pages"}
  "n ho" {:do #(telescope.vim_options) :description "Vim options"}
  "n ha" {:do #(telescope.autocommands) :description "List autocommands"}
  "n hk" {:do #(telescope.keymaps) :description "List keymaps"}
  ; Debug mappings <leader>d
  "n db" {:do #(dap.toggle_breakpoint) :description "Toggle breakpoint"}
  "n dc" {:do #(dap.continue) :description "Continue"}
  "n ds" {:do #(dap.step_into) :description "Step into"}
  "n dS" {:do #(dap.step_over) :description "Step over"}
  "n dr" {:do #(dap.repl.open) :description "REPL"}
  "n dh" {:do #(dap-variables.hover) :description "Inspect variable"}
  "n dH" {:do #(dap-variables.visual_hover) :description "Inspect variable (visual)"}
} {:noremap true} which-key-map)

(set nvim.g.which_key_map which-key-map)

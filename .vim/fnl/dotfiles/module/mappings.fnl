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
            qf dotfiles.quickfix
            keymap dotfiles.keymap}})

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
  :d {:name "+documentation"}
  :j {:name "+jump"
      :m {:name "+marks"}
      :c {:name "+changes"}
      :e {:name "+errors"}
      :q {:name "+quickfix"}}
  :t {:name "+toggle"}})

(keymap.register-mappings {
  "n " {:do #(which-key.start false) :silent true}
  "v " {:do #(which-key.start true) :silent true}
  "i<C-Space>" {:do "completion#trigger_completion()" :silent true :expr true}
  "n <CR>" {:do ":Marks<CR>" :description "Jump to mark"}
  "ijj" {:do "<esc>" :description "Exit insert mode"}
  "t<C-j><C-j>" {:do "<C-\\><C-n>" :description "Exit terminal mode"}
  "nU" {:do "<C-r>" :description "Redo"}
  "n/" {:do "/\\v" :description "Search with magic"}
  "n?" {:do "?\\v" :description "Search backwards with magic"}
  "nK" {:do #(util.show-documentation false) :silent true :description "Show documentation"}
  "ngh" {:do #(util.show-documentation true) :silent true :description "Show documentation"}
  "i<C-l>" {:do "<Plug>(fzf-complete-line)"}
  "i<C-e>" {:do "<Plug>(fzf-complete-path)"}
  "i<C-w>" {:do "<Plug>(fzf-complete-word)"}
  "i<C-u>" {:do #(files.insert-relative-path (nvim.fn.expand "%:p:h"))}
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
  "n ," {:do "<Cmd>Buffers<CR>" :description "Switch buffer"}
  "n ." {:do "<Cmd>Files<CR>" :description "Find files"}
  "n  " {:do "<Cmd>Commands<CR>^"}
  "n \"" {:do "q:" :description "Ex History"}
  "v \"" {:do "q:" :description "Ex History"}
  "n x" {:do "<Cmd>sp e<CR>" :description "Scratch buffer"}
  ; File mappings <leader>f
  "n fs" {:do "<Cmd>w<CR>" :description "Save file"}
  "n fS" {:do "<Cmd>wa<CR>" :description "Save all files"}
  "n f/" {:do "<Cmd>BLines<CR>" :description "Search lines"}
  "n ff" {:do "<Plug>(Prettier)" :description "Format file"}
  "n fo" {:do "<Cmd>Dirvish %:p:h<CR>" :description "Show in tree"}
  "n fO" {:do "<Cmd>vsp +Dirvish %:p:h<CR>" :description "Show in split tree"}
  "n fr" {:do "<Cmd>History<CR>" :description "Open recent files"}
  "n fu" {:do "<Cmd>UndotreeToggle<CR>" :description "Undo tree"}
  "n fU" {:do "<Cmd>UndotreeFocus<CR>" :description "Focus undo tree"}
  "n fE" {:do "<Cmd>vsp $MYVIMRC<CR>" :description "Edit .vimrc"}
  "n fF" {:do "<Cmd>Files %:p:h<CR>" :description "Find from file"}
  "n fP" {:do "<Cmd>Files ~/.vim/lua<CR>" :description "Find config file"}
  ; Buffer mappings <leader>b
  "n bp" {:do "<Cmd>bprevious<CR>" :description "Previous buffer"}
  "n bn" {:do "<Cmd>bnext<CR>" :description "Next buffer"}
  "n bf" {:do "<Cmd>bfirst<CR>" :description "First buffer"}
  "n bl" {:do "<Cmd>blast<CR>" :description "Last buffer"}
  "n bd" {:do "<Cmd>bp<CR>:bd#<CR>" :description "Delete buffer"}
  "n bk" {:do "<Cmd>bp<CR>:bw!#<CR>" :description "Wipe buffer"}
  "n bK" {:do #(delete-buffers-fzf) :description "Wipe buffers"}
  "n bb" {:do "<Cmd>Buffers<CR>" :description "List buffers"}
  "n bY" {:do "ggyG" :description "Yank buffer"}
  "n bm" {:do #(util.prompt-command :mark "Set mark") :description "Set mark"}
  ; Window mappings <leader>w
  "n ww" {:do "<C-W>w" :description "Move below/right"}
  "n wa" {:do "<Cmd>Windows<CR>" :description "List windows"}
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
  "n w/" {:do "<Cmd>Windows<CR>" :description "Search windows"}
  "n wS" {:do "<Cmd>Startify<CR>" :description "Start screen"}
  ; Project mappings <leader>p
  "n ph" {:do "<Cmd>History<CR>" :description "MRU"}
  "n pf" {:do "<Cmd>Files .<CR>" :description "Find file"}
  "n pF" {:do "<Cmd>Files! .<CR>" :description "Find file fullscreen"}
  "n ps" {:do #(let [word (nvim.fn.expand "<cword>")]
                 (nvim.ex.Files ".")
                 (nvim.input word))
          :description "Find file with text"}
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
  "n jr" {:do #(vim.lsp.buf.references) :description "Type references"}
  "n jep" {:do "<Cmd>PrevDiagnosticCycle<CR>" :description "Previous error"}
  "n jen" {:do "<Cmd>NextDiagnosticCycle<CR>" :description "Next error"}
  "n jqp" {:do "<Cmd>cN<CR>" :description "Previous"}
  "n jqn" {:do "<Cmd>cn<CR>" :description "Next"}
  "n jn" {:do "<C-o>" :description "Next jump"}
  "n jp" {:do "<C-i>" :description "Previous jump"}
  "n jml" {:do "<Cmd>Marks<CR>" :description "List marks"}
  "n jmd" {:do ":delmarks<Space>" :description "Delete marks"}
  "n jmm" {:do "`" :description "Go to mark"}
  "n ja" {:do "<Cmd>A<CR>" :description "Go to altenate"}
  "n jA" {:do "<Cmd>AV<CR>" :description "Split altenate"}
  "n jcn" {:do "g," :description "Next change"}
  "n jcp" {:do "g;" :description "Previous change"}
  ; Insert mappings <leader>i
  "n if" {:do "\"%p" :description "Current file name"}
  "n iF" {:do "<Cmd>put expand(\"%:p\")<CR>" :description "Current file path"}
  "n is" {:do "<Cmd>Snippets<CR>" :description "Insert snippet"}
  ; Search mappings <leader>s
  "n sd" {:do "<Cmd>FlyDRg<CR>" :description "Grep files in directory"}
  "n sc" {:do "<Cmd>History:<CR>" :description "Search command history"}
  "n sh" {:do "<Cmd>History/<CR>" :description "Search history"}
  "n si" {:do #(vim.lsp.buf.workspace_symbol) :description "Search symbol"}
  "n sb" {:do "<Cmd>BLines<CR>" :description "Search buffer"}
  "n ss" {:do "<Cmd>BLines<CR>" :description "Search buffer"}
  "n so" {:do #(vim.lsp.buf.document_symbol) :description "List symbols in file"}
  "n sl" {:do "<Cmd>Lines<CR>" :description "Search lines"}
  "n sp" {:do "<Cmd>FlyRg<CR>" :description "Grep files in project"}
  "n sP" {:do "<Cmd>FlyRg!<CR>" :description "Grep files in project (full)"}
  "n sm" {:do "<Cmd>Marks<CR>" :description "Jump to marks"}
  "n sa" {:do #(grep.flygrep "" (nvim.fn.expand "%:p:h") 0 ["--hidden" "--no-ignore"]) :description "Grep all files"}
  "n sS" {:do ":Rg <C-r><C-w><CR>" :description "Search selected text (project)"}
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
  "n cD" {:do #(vim.lsp.buf.references) :description "Type references"}
  "n ck" {:do "gh" :description "Jump to documentation" :noremap false}
  "n cr" {:do #(vim.lsp.buf.rename) :description "LSP rename"}
  "n cR" {:do #(do
                 (-> (vim.lsp.get_active_clients)
                     (vim.lsp.stop_client))
                 (nvim.command "e!"))
          :description "LSP reload"}
  "n cs" {:do #(vim.lsp.buf.signature_help) :description "Signature help"}
  "n cj" {:do #(vim.lsp.buf.document_symbol) :description "Jump to symbol"}
  "n cJ" {:do #(vim.lsp.buf.workspace_symbol) :description "Jump to symbol in workspace"}
  "n ca" {:do #(vim.lsp.buf.code_action) :description "LSP code actions"}
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
  ; "n gB" { function() steel.git.checkout_git_branch_fzf(vim.fn.expand("%:p:h")) end , :description "Checkout branch"}
  "n gs" {:do "<Cmd>G<CR>" :description "Git status"}
  "n gd" {:do "<Cmd>Gdiffsplit<CR>" :description "Git diff"}
  "n ge" {:do "<Cmd>Gedit<CR>" :description "Git edit"}
  "n gg" {:do #(term.float-cmd "lazygit") :description "Git GUI"}
  "n gl" {:do "<Cmd>Commits<CR>" :description "Git log"}
  "n gL" {:do "<Cmd>BCommits<CR>" :description "Git file log"}
  "n gF" {:do "<Cmd>Gfetch<CR>" :description "Git fetch"}
  "n gp" {:do "<Cmd>Gpull<CR>" :description "Git pull"}
  "n gP" {:do "<Cmd>Gpush<CR>" :description "Git push"}
  "n gb" {:do "<Cmd>Gblame<CR>" :description "Git blame"}
  "n gfc" {:do #(keymap.unimplemented) :description "Find commit"}
  "n gff" {:do #(keymap.unimplemented) :description "Find file"}
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
  "n te" {:do #(let [cur nvim.g.diagnostic_enable_virtual_text]
                 (->> (if (= cur 1) 0 1)
                      (set nvim.g.diagnostic_enable_virtual_text)))
          :description "Inline errors"}
  ; Help mappings <leader>h
  "n hh" {:do "<Cmd>Helptags<CR>" :description "Help tags"}
} {:noremap true} which-key-map)

(set nvim.g.which_key_map which-key-map)
; I can't get the following mappings to work in lua...
(nvim.command "
  function! CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\\s'
  endfunction")

; Use tab for trigger completion with characters ahead and navigate.
; Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
(nvim.command "inoremap <silent><expr> <TAB> pumvisible() ? \"\\<C-n>\" : CheckBackSpace() ? \"\\<TAB>\" : completion#trigger_completion()")
(nvim.command "inoremap <expr><S-TAB> pumvisible() ? \"\\<C-p>\" : \"\\<C-h>\"")
(module dotfiles.files
  {require {util dotfiles.util}})

(defn to-relative-path [from-path to-path from-root?]
  (let [require (if from-root?
                  (string.format "require('path').relative('%s', '%s/%s')"
                                 from-path
                                 (vim.fn.getcwd)
                                 to-path)
                  (string.format "require('path').relative('%s', '%s')"
                                 from-path
                                 to-path))
        cmd (string.format "node -p %q" require)
        lines (util.exec cmd)]
    (or (. lines 1) "")))

(defn nearest [filename path options?]
  "Gets the nearest file path from the given directory and filename"
  (let [options (or options? {})
        cmd (if options.all
              "nearest %s --from %s --all"
              "nearest %s --from %s")
        handle (-> cmd
                   (string.format filename path)
                   (io.popen))
        result (handle:read "*a")]
    (handle:close)
    (if options.all
      (util.split result "\n")
      result)))

(defn get-fname-prefix [str]
  "Gets a file path prefix. This is ported from fzf.vim."
  (var isf vim.o.isfname)
  (let [white {}
        black {}]
    (when (string.match isf ",,,")
      (do
        (tset white "," true)
        (set isf (vim.fn.substitute isf ",,," "," "g"))))
    (when (string.match isf ",^,,")
      (do
        (tset black "," true)
        (set isf (vim.fn.substitute isf ",^,," "," "g"))))
    (each [_ _token (ipairs (vim.fn.split isf ","))]
      (var token _token)
      (var target white)
      (when (= (string.sub token 1 1) "^")
        (set target black)
        (set token (string.sub token 2)))
      (var ends (string.match token "(.+)-(.+)"))
      (if (not ends)
        (tset target token true)
        (do
          (set ends (-> [(. ends 2) (. ends 3)]
                        (vim.fn.map "len(v:val) == 1 ? char2nr(v:val) : str2nr(v:val)")))
          (each [_ i (ipairs (vim.fn.range (. ends 1) (. ends 2)))]
            (tset target (vim.fn.nr2char i) true)))))
    (var prefix str)
    (var found false)
    (var start-col 1)
    (each [_ offset (ipairs (vim.fn.range 1 (length str)))]
      (local index (- (length str) offset))
      (var char (string.sub str index index))
      (if (and (or (string.match char "%w")
                   (. white char))
               (not (. black char)))
        (util.noop)
        (when (not found)
          (do
            (set prefix (string.sub str (+ (- (length str) offset) 1)))
            (set start-col (- (length str) (- offset 1)))
            (set found true)))))
    {: prefix
     : start-col
     :end-col (length str)}))

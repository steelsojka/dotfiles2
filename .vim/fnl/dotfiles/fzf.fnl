(module dotfiles.fzf
  {require {nvim aniseed.nvim
            rx dotfiles.rx
            funcref dotfiles.funcref
            core aniseed.core
            util dotfiles.util}})

(defn- extract-data-items [results data]
  (core.reduce #(let [index (string.match $2 "%d+$")]
                   (when index
                     (let [idx (tonumber index)]
                       (when (. data idx)
                         (table.insert $1 (. data idx)))))
                   $1) [] results))

(defn execute [fzf cmd]
  (tset nvim.g fzf.fn-name cmd)
  (when cmd.data
    (set fzf.data cmd.data))
  (if (~= (type fzf.sink-ref) :string)
    (nvim.command (string.format "let g:%s[\"sink%s\"] = %s"
                                 fzf.fn-name
                                 (if fzf.handle-all "*" "") (fzf.sink-ref.get-vim-ref-string)))
    (nvim.command (string.format "let g:%s[\"sink\"] = \"%s\""
                                 fzf.fn-name
                                 fzf.sink-ref)))
  (nvim.command (string.format "call fzf#run(fzf#wrap(g:%s))" fzf.fn-name))
  (nvim.command (.. "unlet g:" fzf.fn-name)))

(defn create [sink options]
  (let [opts (or options {})
        instance {:subscription (rx.new-subscription)
                  :sink-ref sink
                  :fn-name (.. :k (util.unique-id))
                  :handle-all opts.handle-all
                  :execute #(execute instance $1)
                  :unsubscribe #(instance.subscription.unsubscribe)
                  :data nil}]
    (when (= (type sink) :function)
      (set instance.sink-ref
           (funcref.create #(do
                             (var data instance.data)
                             (when opts.indexed_data
                               (when (not instance.data)
                                 (error "No data provided to FZF"))
                               (when (not (vim.tbl_islist $2 ))
                                 (error "FZF results must be a list"))
                               (set data (extract-data-items $2 data)))
                             (sink $1 $2 data)
                             (set instance.data nil))))
      (instance.subscription.add instance.sink-ref.subscription))
    instance))

(defn create-grid [headings items delimiter]
  (var new-items [])
  (var header-row [])
  (var _delimiter (or delimiter " "))
  (each [index item (ipairs headings)]
    (let [heading item.heading]
      (var result heading)
      (when (type item.map :function)
        (set result (item.map result)))
      (when item.length
        (let [diff (- item.length (length heading))]
          (set result (.. result (string.rep _delimiter diff)))))
      (table.insert header-row result)))
  (table.insert new-items header-row)
  (each [_ item-parts (ipairs items)]
    (local new-item [])
    (each [i item-part (ipairs item-parts)]
      (let [heading (. headings i)
            is-tbl (= (type item-part) :table)
            value (if is-tbl
                    (if item-part.value item-part.value "")
                    item-part)]
        (var res value)
        (when (and heading heading.truncate heading.length (> (length res) heading.length))
          (local diff (->> (length value) (- heading.length)))
          (set res (.. res (string.rep _delimiter diff))))
        (table.insert new-item res)))
    (table.insert new-items new-item))
  new-items)

(defn grid-to-source [grid delimiter]
  (let [del (or delimiter " ")]
    (core.map #(table.concat $1 del) grid)))


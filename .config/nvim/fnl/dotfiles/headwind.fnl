(module dotfiles.headwind
  {require {keymap dotfiles.keymap}})

(defn add-buf-mappings []
  (let [headwind (require "headwind")]
    (keymap.init-buffer-mappings {:t {:name "+tailwind"}})
    (keymap.register-buffer-mappings
      {"n mts" {:do #(headwind.buf_sort_tailwind_classes) :description "Sort tailwind classes"}
       "v mts" {:do #(headwind.visual_sort_tailwind_classes) :description "Sort tailwind classes"}})))

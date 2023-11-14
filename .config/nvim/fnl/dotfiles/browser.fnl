(module dotfiles.browser
  {require {terminal dotfiles.terminal
            utils dotfiles.util}})

(local search-engines
  [{:name "Duck Duck Go"
    :url #(string.format "https://duckduckgo.com?q=%s" $)}
   {:name "Google"
    :url #(string.format "https://google.com/search?q=%s" $)}
   {:name "MDN"
    :url #(string.format "https://duckduckgo.com?q=site:developer.mozilla.org+%s" $)}
   {:name "reddit"
    :url #(string.format "https://www.reddit.com/search?q=%s" $)}
   {:name "npmjs.org"
    :url #(string.format "https://www.npmjs.com/search?q=%s" $)}
   {:name "Sourcegraph"
    :url #(let [source-graph-url (utils.get-var "sourcegraph_url")
                query (string.gsub $ "%s" "+")]
            (string.format "%s?q=%s" source-graph-url query))}])


(defn open-url [url external?]
  (let [system (require "steelvim.system")
        cmd (if system.is_mac_os "open" "xdg-open")]
    (if external?
      (vim.cmd (string.format "!open \"%s\"" url))
      (do
        (vim.cmd "vsp")
        (vim.cmd (string.format "terminal w3m \"%s\"" url))
        (vim.schedule #(vim.cmd "startinsert"))))))

(defn search [term? search-engine? external?]
  (let [term (or term? "")
        query (string.gsub term "%s" "+")]
    (if (not search-engine?)
      (vim.ui.select
        search-engines
        {:format_item #$.name
         :prompt "Search Engine: "}
        #(open-url ($.url query) external?))
      (open-url (search-engine?.url query) external?))))

(defn prompt-search [external?]
  (vim.ui.input {:prompt "Search: "}
                #(when $1 (search $1 nil external?))))

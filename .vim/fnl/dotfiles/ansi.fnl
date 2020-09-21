(module dotfiles.ansi)

(def- colors {:black 30
              :red 31
              :green 32
              :yellow 33
              :blue 34
              :magenta 35
              :cyan 36})

(defn color [color text]
  (.. (string.char 27) "[" (. colors color) "m" text (string.char 27) "[m"))

(def black (partial color :black))
(def red (partial color :red))
(def green (partial color :green))
(def yellow (partial color :yellow))
(def blue (partial color :blue))
(def magenta (partial color :magenta))
(def cyan (partial color :cyan))

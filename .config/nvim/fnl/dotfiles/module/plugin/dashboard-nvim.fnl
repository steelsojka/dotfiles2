(module dotfiles.module.plugin.dashboard-nvim)

(local header [
"   .x+=:.        s                                ..    _            .                        "
"  z`    ^%      :8                          x .d88'    u            @88>                      "
"     .   <k    .88                           5888R    88Nu.   u.    %8P      ..    .     :    "
"   .@8Ned8'   :888ooo      .u         .u     '888R   '88888.o888c    .     .888: x888  x888.  "
" .@^%8888'  -*8888888   ud8888.    ud8888.    888R    ^8888  8888  .@88u  ~`8888~'888X`?888f` "
"x88:  `)8b.   8888    :888'8888. :888'8888.   888R     8888  8888 ''888E`   X888  888X '888>  "
"8888N=*8888   8888    d888 '88%' d888 '88%'   888R     8888  8888   888E    X888  888X '888>  "
" %8'    R88   8888    8888.+'    8888.+'      888R     8888  8888   888E    X888  888X '888>  "
"  @8Wou 9%   .8888Lu= 8888L      8888L        888R    .8888b.888P   888E    X888  888X '888>  "
".888888P`    ^%888*   '8888c. .+ '8888c. .+  .888B .   ^Y8888*''    888&   '*88%''*88' '888!` "
"`   ^'F        'Y'     '88888%    '88888%    ^*888%      `Y'        R888'    `~    '    `'`   "
"                         'YP'       'YP'       '%                    ''                       "])

(defn configure []
  (let [dashboard (require "dashboard")]
    (->
      {:config
       {: header
        :project {:enable true :limit 8}
        :mru {:limit 10}}
       :theme "hyper"
       :shortcut_type "number"}
      (dashboard.setup))))

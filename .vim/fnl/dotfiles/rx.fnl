(module dotfiles.rx)

(defn add-subscription [sub _fn]
  (table.insert sub.fns _fn))

(defn unsubscribe [sub]
  (when sub.closed
    (error "Subscription is already unsubscribed from."))
  (each [i _fn (ipairs sub.fns)]
    (if (and (type _fn "table") (type _fn.unsubscribe "function"))
      (fn.unsubscribe)
      (type _fn "function")
      (_fn)))
  (set sub.closed true))

(defn new-subscriber [subscriber]
  {:next (fn [v] (when subscriber.next (subscriber.next v)))
   :error (fn [err] (when subscriber.error (subscriber.error err)))
   :complete (fn [] (when subscriber.complete (subscriber.complete)))})

(defn new-subscription [cleanup]
  (let [sub {:fns {}
             :closed false
             :unsubscribe (fn [] (unsubscribe sub))
             :add (fn [...] (add-subscription sub ...))}]
    (when cleanup
      (table.insert sub.fns cleanup))
    sub))

(defn subscribe [source subscriber]
  (let [subscription (new-subscription)
        _subscriber (new-subscriber {:next subscriber.next
                                     :error subscriber.error
                                     :complete (fn []
                                                 (when subscriber.complete (subscriber.complete))
                                                 (subscription.unsubscribe))})]
    (when source.sink
      (subscription.add (source.sink _subscriber)))
    subscription))

(defn new-observable [sink]
  (let [source {:sink sink
                :subscribe (fn [...] (subscribe source ...))}]
  source))

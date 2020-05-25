local Observable = {}

function Observable:create(sink)
  local instance = {
    sink = sink
  }

  return setmetatable(instance, {
    __index = Observable
  })
end

function Observable:subscribe(_subscriber)
  local subscription = steel.rx.subscription:create();
  local subscriber = steel.rx.subscriber:create({
    next = _subscriber.next,
    error = _subscriber.error,
    complete = function()
      if _subscriber.complete then
        _subscriber.complete()
      end

      subscription:unsubscribe()
    end
  })

  if self.sink then
    subscription:add(self.sink(subscriber));
  end

  return subscription
end

return Observable

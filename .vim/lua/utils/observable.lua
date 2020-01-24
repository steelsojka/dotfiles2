local Subscriber = require 'utils/subscriber'
local Subscription = require 'utils/subscription'

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
  local subscription = Subscription:create();
  local subscriber = Subscriber:create({
    next = _subscriber.next,
    error = _subscriber.error,
    complete = function()
      if _subscriber.complete then
        _subscriber:complete()
      end

      subscription:unsubscribe()
    end
  })

  subscription:add(self.sink(subscriber));

  return subscription
end

return Observable

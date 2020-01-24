local Subscriber = {}

function Subscriber:create(subscriber)
  local instance = {
    next = subscriber.next or function() end,
    error = subscriber.error or function() end,
    complete = subscriber.complete or function() end
  }

  return setmetatable(instance, {
    __index = Subscriber
  })
end

return Subscriber

local Subscriber = {}

function Subscriber:create(subscriber)
  local instance = {
    _next = subscriber.next;
    _error = subscriber.error;
    _complete = subscriber.complete;
  }

  return setmetatable(instance, {
    __index = Subscriber
  })
end

function Subscriber:next(v)
  if self._next then self._next(v) end
end

function Subscriber:error(err)
  if self._error then self._error(err) end
end

function Subscriber:complete()
  if self._complete then self._complete() end
end

return Subscriber

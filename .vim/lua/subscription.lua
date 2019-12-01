local Subscription = {}

function Subscription:create(cleanup)
  local sub = {}

  sub.fns = {}
  sub.closed = false

  if cleanup then
    table.insert(sub.fns, cleanup)
  end

  return setmetatable(sub, {
    __index = Subscription
  })
end

function Subscription:unsubscribe()
  if self.closed then
    error('Subscription is already unsubscribed from.')
  end

  for __,fn in pairs(self.fns) do
    if type(fn) == 'table' and type(fn['unsubscribe']) == 'function' then
      fn:unsubscribe()
    elseif type(fn) == 'function' then
      fn()
    end
  end

  self.closed = true
end

function Subscription:add(fn)
  table.insert(self.fns, fn)
end

return Subscription

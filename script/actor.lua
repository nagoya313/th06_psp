player = {}

function player:new()
  local instance = {}
  setmetatable(instance, self)
  self.__index = self
  return instance
end

shot = {}

function shot:new(character_id)
  local instance = {}
  instance.co = coroutine.create(function (self) self:move() end)
  instance.key = tostring(instance.co)
  add_image(instance.key, character_id)
  resize_actor(instance.key, 16, 16)
  set_actor_uv(instance.key, 128, 0, 16, 16)
  local x, y = get_actor_position('player')
  move_actor(instance.key, x + 8, y - 16)
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function shot:update()
  coroutine.resume(self.co, self)
end

function shot:erase()
  erase_actor(self.key)
end

function shot:move()
  while true do
  	move_actor(self.key, 0, -20)
  	coroutine.yield()
  end
end

function shot:get_position()
  local x, y = get_actor_position(self.key)
  return x, y
end

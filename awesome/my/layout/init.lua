local wrequire     = require("lain.helpers").wrequire
local setmetatable = setmetatable

local layout       = { _NAME = "my.layout" }

return setmetatable(layout, { __index = wrequire })

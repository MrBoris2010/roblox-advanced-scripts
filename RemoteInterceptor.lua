-- RemoteInterceptor.lua
local Interceptor = {}
local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	if method == "FireServer" or method == "InvokeServer" then
		print("[Remote Call]", method, self:GetFullName(), ...)
	end
	return oldNamecall(self, ...)
end)

return Interceptor

RegisterNetEvent('test:reportback')
AddEventHandler('test:reportback', function(resName)
--	if resName == GetCurrentResourceName() then
	print("checking2")
	local data = LoadResourceFile(resName, "client.lua")
	local length = string.len(data)
	TriggerServerEvent('test:reportinput', GetCurrentResourceName(), length)
	--end
end)

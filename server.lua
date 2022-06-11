local ServerResNameTable = {}
local ResourceLenTable = {}



RegisterServerEvent('test:reportinput')
AddEventHandler('test:reportinput', function(resourceName, length)
		if ResourceLenTable[resourceName] ~= length then
			print("caught")
		end
end)

function GetResNames()
	for i = 0, GetNumResources() do
		local name = GetResourceByFindIndex(i)
			if name ~= nil then
				ServerResNameTable[i] = name
			end
	end
end


function GetLengths()
	for i = 0, #ServerResNameTable do

		local data = LoadResourceFile(ServerResNameTable[i], "client.lua")

		if data ~= nil then
		local length = string.len(data)
		print("Resource name of: ".. ServerResNameTable[i] .. " with index: " .. i)
		print("length : " .. length)


		ResourceLenTable[ServerResNameTable[i]] = length
		else
			if ServerResNameTable[i] ~= nil then
			print("not exec on: ".. ServerResNameTable[i])
			end
		end

	end
end


AddEventHandler('onResourceStart', function(resourceName)
	ServerResNameTable = {}
	ResourceLenTable = {}
	collectgarbage()

	GetResNames()
	GetLengths()

	--print("this resource client length: " .. ResourceLenTable[GetCurrentResourceName()])
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(20000)
		print("checking")
		for i = 0, #ServerResNameTable do
			local name = ServerResNameTable[i]
			TriggerClientEvent("test:reportback", -1, name)
		end

	end
end)
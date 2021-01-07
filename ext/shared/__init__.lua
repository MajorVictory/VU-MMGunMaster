
-- enable debug messages in console
function dprint(message)
	if (false) then -- true = on, false = off
		print(message)
	end
end

-- load resource list
mmResources = require('__shared/MMResources')
-- modules
mmPlayers = require('__shared/MMPlayers')
mmWeapons = require('__shared/MMWeapons')

-- loop registered resources to listen for
for resourceName, resourceData in pairs(mmResources:Get()) do
	if (resourceData.Partition and resourceData.Instance) then
		ResourceManager:RegisterInstanceLoadHandler(Guid(resourceData.Partition), Guid(resourceData.Instance), function(instance)
		  mmResources:SetLoaded(resourceName, true)
		  dprint("Resource Loaded: "..tostring(resourceName))
		  mmPlayers:Write(mmResources)
		  mmWeapons:Write(mmResources)
		end)
	end
end

Events:Subscribe('Partition:Loaded', function(partition)
	for _, instance in pairs(partition.instances) do

		-- remove explosion supression
		if (instance:Is('VeniceExplosionEntityData')) then
			local expData = VeniceExplosionEntityData(instance)
			expData:MakeWritable()
			expData.triggerImpairedHearing = false
			expData.isCausingSuppression = false
			dprint('Removed Explosion Supression ['..instance.instanceGuid:ToString('D')..']...')
		end

		-- adjust Gun Master level kills
		if (instance:Is('GunMasterKillCounterEntityData')) then
			mmWeapons:SetGMLevelKills(instance)
			dprint('Changed Gun Master kill requirements...')
		end
	end
end)

-- negate damage from hitting stuff because 2FAST
Hooks:Install('Soldier:Damage', 1987, function(hook, soldier, info, giverInfo)

  	-- no collision damage or 'Count' damage
	if giverInfo.damageType == 4 or giverInfo.damageType == 6 then
		info.damage = 0
		hook:Return()
  	end

  	hook:Pass(soldier, info, giverInfo)
end)

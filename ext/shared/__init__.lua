require('__shared/MMUtils')

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
		  print("Resource Loaded: "..tostring(resourceName))
		  mmPlayers:Write(mmResources)
		  mmWeapons:Write(mmResources)
		end)
	end
end

-- Thanks to Powback's bundle mounter: https://github.com/BF3RM/BundleMounter
--[[
Events:Subscribe('BundleMounter:GetBundles', function(bundles)
	Events:Dispatch('BundleMounter:LoadBundles', 'Levels/MP_007/MP_007', {
		'Levels/MP_007/MP_007',
		'Levels/MP_007/Rush'
	})
	Events:Dispatch('BundleMounter:LoadBundles', 'Levels/SP_Tank/SP_Tank', {
		'Levels/SP_Tank/SP_Tank',
		'Levels/SP_Tank/HighwayToTeheran_01',
	})
    Events:Dispatch('BundleMounter:LoadBundles', 'Xp3Chunks', {
    	'Xp3Chunks'
    })
	Events:Dispatch('BundleMounter:LoadBundles', 'Levels/XP3_Desert/XP3_Desert', {
		'Levels/XP3_Desert/XP3_Desert'
	})
	--Events:Dispatch('BundleMounter:LoadBundles', 'SpChunks', {})
    --Events:Dispatch('BundleMounter:LoadBundles', 'CoopChunks', {})
    --Events:Dispatch('BundleMounter:LoadBundles', 'MpChunks', {})
    --Events:Dispatch('BundleMounter:LoadBundles', 'Chunks0', {})
    --Events:Dispatch('BundleMounter:LoadBundles', 'Chunks1', {})
    --Events:Dispatch('BundleMounter:LoadBundles', 'Chunks2', {})
    --Events:Dispatch('BundleMounter:LoadBundles', 'Xp1Chunks', {})
    --Events:Dispatch('BundleMounter:LoadBundles', 'Xp2Chunks', {})
    --Events:Dispatch('BundleMounter:LoadBundles', 'Xp4Chunks', {})
    --Events:Dispatch('BundleMounter:LoadBundles', 'Xp5Chunks', {})
end)
]]

Events:Subscribe('Partition:Loaded', function(partition)
	for _, instance in pairs(partition.instances) do

		-- remove explosion supression
		if (instance:Is('VeniceExplosionEntityData')) then

			local expData = VeniceExplosionEntityData(instance)
			expData:MakeWritable()
			expData.triggerImpairedHearing = false
			expData.isCausingSuppression = false
			print('Removed Explosion Supression ['..instance.instanceGuid:ToString('D')..']...')
		end
	end
end)

-- negate damage from hitting stuff because 2FAST
Hooks:Install('Soldier:Damage', 1987, function(hook, soldier, info, giverInfo)

	local debugDamage = false

	if debugDamage then
		SharedUtils:Print('Soldier:Damage --------------------------------')
	end

	if debugDamage and giverInfo ~= nil then
		SharedUtils:Print('giverInfo.damageType: '..tostring(giverInfo.damageType))
	end

	if debugDamage and giverInfo ~= nil and giverInfo.giver ~= nil then
		SharedUtils:Print('giverInfo.giver.name: '..tostring(giverInfo.giver.name))
		SharedUtils:Print('giverInfo.giver.id: '..tostring(giverInfo.giver.id))
		SharedUtils:Print('giverInfo.giver.onlineId: '..tostring(giverInfo.giver.onlineId))
		SharedUtils:Print('giverInfo.giver.hasSoldier: '..tostring(giverInfo.giver.hasSoldier))
		SharedUtils:Print('giverInfo.giver.alive: '..tostring(giverInfo.giver.alive))
	end

	if debugDamage and info ~= nil then
		SharedUtils:Print('info.damage: '..tostring(info.damage))
		SharedUtils:Print('info.collisionSpeed: '..tostring(info.collisionSpeed))
		SharedUtils:Print('info.stamina: '..tostring(info.stamina))
		SharedUtils:Print('info.isDemolitionDamage: '..tostring(info.isDemolitionDamage))
		SharedUtils:Print('info.isExplosionDamage: '..tostring(info.isExplosionDamage))
		SharedUtils:Print('info.isBulletDamage: '..tostring(info.isBulletDamage))
		SharedUtils:Print('info.isClientDamage: '..tostring(info.isClientDamage))
		SharedUtils:Print('info.shouldForceDamage: '..tostring(info.shouldForceDamage))
	end

	if debugDamage then
		SharedUtils:Print('-----------------------------------------------')
	end

  	-- no collision damage or 'Count' damage
	if giverInfo.damageType == 4 or giverInfo.damageType == 6 then
		info.damage = 0
		hook:Return()
  	end

  	hook:Pass(soldier, info, giverInfo)
end)

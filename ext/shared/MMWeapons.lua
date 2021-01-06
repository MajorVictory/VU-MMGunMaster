class "MMWeapons"

function MMWeapons:Write(mmResources)

	if (mmResources:IsLoaded('gmpreset_0') and mmResources:IsLoaded('gmpreset_0_xp4')) then
		mmResources:SetLoaded('gmpreset_0', false)
		mmResources:SetLoaded('gmpreset_0_xp4', false)

		for _,resourceName in pairs({'gmpreset_0','gmpreset_0_xp4'}) do

			local gmCounterData = GunMasterKillCounterEntityData(mmResources:GetInstance(resourceName))
			gmCounterData:MakeWritable()
			local gmDataLevels = gmCounterData.weaponsPreset[0].gunMasterLevelInfos

			print('Weapon Preset ['..resourceName..']: '..tostring(#gmDataLevels)..' Entries...')
		end
	end


	if (mmResources:IsLoaded('mp443_gm')) then
		mmResources:SetLoaded('mp443_gm', false)

		local weaponBP = SoldierWeaponBlueprint(mmResources:GetInstance('mp443_gm'))
		local weaponData = SoldierWeaponData(weaponBP.object)

		for i=1, #weaponData.weaponModifierData do
			local weaponModData = WeaponModifierData(weaponData.weaponModifierData[i])
			local unlockAsset = UnlockAsset(weaponModData.unlockAsset)
			if (unlockAsset.name == 'Gameplay/XP2/GM_Deploytime') then
				for j=1, #weaponModData.modifiers do
					local unlockMod = weaponModData.modifiers[j]
					if (unlockMod:Is('WeaponMagazineModifier')) then
						local magMod = WeaponMagazineModifier(unlockMod)
						magMod:MakeWritable()
						magMod.magazineCapacity = 100
					end
				end
			end
		end


		local fireData = FiringFunctionData(weaponData.weaponFiring.primaryFire)
		fireData:MakeWritable()
		fireData.shot.initialSpeed.z = 450
		fireData.fireLogic.rateOfFire = 900
		fireData.ammo.magazineCapacity = 100
		fireData.ammo.numberOfMagazines = -1
		
		local bulletData = BulletEntityData(fireData.shot.projectileData)
		bulletData:MakeWritable()
		bulletData.gravity = -9.8
		bulletData.startDamage = 600
		bulletData.endDamage = 900
		bulletData.damageFalloffStartDistance = 0
		bulletData.damageFalloffEndDistance = 15
		print('Changed [GM] Mp443...')
	end

	if (mmResources:IsLoaded('m93r_gm')) then
		mmResources:SetLoaded('m93r_gm', false)

		local weaponBP = SoldierWeaponBlueprint(mmResources:GetInstance('m93r_gm'))
		local weaponData = SoldierWeaponData(weaponBP.object)

		for i=1, #weaponData.weaponModifierData do
			local weaponModData = WeaponModifierData(weaponData.weaponModifierData[i])
			local unlockAsset = UnlockAsset(weaponModData.unlockAsset)
			if (unlockAsset.name == 'Gameplay/XP2/GM_Deploytime') then
				for j=1, #weaponModData.modifiers do
					local unlockMod = weaponModData.modifiers[j]
					if (unlockMod:Is('WeaponMagazineModifier')) then
						local magMod = WeaponMagazineModifier(unlockMod)
						magMod:MakeWritable()
						magMod.magazineCapacity = 5
					end
				end
			end
		end


		local fireData = FiringFunctionData(weaponData.weaponFiring.primaryFire)
		fireData:MakeWritable()
		fireData.shot.initialSpeed.z = 380
		fireData.shot.numberOfBulletsPerBurst = 5
		fireData.fireLogic.rateOfFire = 900
		fireData.ammo.magazineCapacity = 5
		fireData.ammo.numberOfMagazines = -1
		
		local bulletData = BulletEntityData(fireData.shot.projectileData)
		bulletData:MakeWritable()
		bulletData.gravity = -9.8
		bulletData.startDamage = 2323
		bulletData.endDamage = 2323
		bulletData.damageFalloffStartDistance = 0
		bulletData.damageFalloffEndDistance = 1
		print('Changed M93r...')
	end

	if (mmResources:IsLoaded('smaw')) then
		mmResources:SetLoaded('smaw', false)

		local fireData = FiringFunctionData(mmResources:GetInstance('smaw'))
		fireData:MakeWritable()
		fireData.shot.initialSpeed.z = 250
		print('Changed SMAW...')
	end

	if (mmResources:IsLoaded('magnum44') and mmResources:IsLoaded('smawmissile')) then
		mmResources:SetLoaded('magnum44', false)
		mmResources:SetLoaded('smawmissile', false)

		local missileData = MissileEntityData(mmResources:GetInstance('smawmissile'))
		missileData:MakeWritable()
		missileData.maxSpeed = 750
		missileData.gravity = -9.8
		missileData.damage = 5000
		print('Changed SMAW Missile...')

		-- swap magnum for smaw rocket
		local fireData = FiringFunctionData(mmResources:GetInstance('magnum44'))
		fireData:MakeWritable()
		fireData.shot.projectileData:MakeWritable()
		fireData.shot.projectileData = ProjectileEntityData(missileData)
		print('Changed Magnum .44...')
	end

	if (mmResources:IsLoaded('pp19') and mmResources:IsLoaded('pp19_bullet')) then
		mmResources:SetLoaded('pp19', false)
		mmResources:SetLoaded('pp19_bullet', false)

		local weaponBP = SoldierWeaponBlueprint(mmResources:GetInstance('pp19'))
		local weaponData = SoldierWeaponData(weaponBP.object)

		for i=1, #weaponData.weaponModifierData do
			local weaponModData = WeaponModifierData(weaponData.weaponModifierData[i])
			local unlockAsset = UnlockAsset(weaponModData.unlockAsset)
			if (unlockAsset.name == 'Gameplay/XP2/GM_Deploytime') then
				for j=1, #weaponModData.modifiers do
					local unlockMod = weaponModData.modifiers[j]
					if (unlockMod:Is('WeaponMagazineModifier')) then
						local magMod = WeaponMagazineModifier(unlockMod)
						magMod:MakeWritable()
						magMod.magazineCapacity = 420
					end
				end
			end
		end

		local fireData = FiringFunctionData(weaponData.weaponFiring.primaryFire)
		fireData:MakeWritable()
		fireData.shot.initialSpeed.z = 380
		fireData.fireLogic.rateOfFire = 1400
		fireData.ammo.magazineCapacity = 420
		fireData.ammo.numberOfMagazines = -1
		
		local bulletData = BulletEntityData(mmResources:GetInstance('pp19_bullet'))
		bulletData:MakeWritable()
		bulletData.gravity = -9.8
		bulletData.startDamage = 120
		bulletData.endDamage = 500
		bulletData.damageFalloffStartDistance = 25
		bulletData.damageFalloffEndDistance = 500
		print('Changed PP-19 Bizon...')
	end

	if (mmResources:IsLoaded('p90') and mmResources:IsLoaded('12gfrag')) then
		mmResources:SetLoaded('p90', false)
		mmResources:SetLoaded('12gfrag', false)
		-- swap p90 for 12gfrag bullets

		local bulletData = BulletEntityData(mmResources:GetInstance('12gfrag'))
		bulletData:MakeWritable()
		bulletData.gravity = -4.5
		bulletData.startDamage = 202
		bulletData.endDamage = 5000
		bulletData.damageFalloffStartDistance = 25
		bulletData.damageFalloffEndDistance = 500
		bulletData.timeToLive = 5
		bulletData.impactImpulse = 40000
		print('Changed 12G Frag Projectile...')

		local fireData = FiringFunctionData(mmResources:GetInstance('p90'))
		fireData:MakeWritable()
		fireData.shot.projectileData:MakeWritable()
		fireData.shot.projectileData = ProjectileEntityData(bulletData)
		fireData.ammo.magazineCapacity = 500
		print('Changed P90...')
	end

	if (mmResources:IsLoaded('spas12')) then
		mmResources:SetLoaded('spas12', false)

		local weaponBP = SoldierWeaponBlueprint(mmResources:GetInstance('spas12'))
		local weaponData = SoldierWeaponData(weaponBP.object)

		for i=1, #weaponData.weaponModifierData do
			local weaponModData = WeaponModifierData(weaponData.weaponModifierData[i])
			local unlockAsset = UnlockAsset(weaponModData.unlockAsset)
			if (unlockAsset.name == 'Gameplay/XP2/GM_Deploytime') then
				for j=1, #weaponModData.modifiers do
					local unlockMod = weaponModData.modifiers[j]
					if (unlockMod:Is('WeaponMagazineModifier')) then
						local magMod = WeaponMagazineModifier(unlockMod)
						magMod:MakeWritable()
						magMod.magazineCapacity = 1
					end
				end
			end
		end

		local fireData = FiringFunctionData(weaponData.weaponFiring.primaryFire)
		fireData:MakeWritable()
		fireData.shot.initialSpeed.z = 380
		fireData.shot.numberOfBulletsPerShell = 250
		fireData.fireLogic.rateOfFire = 900
		fireData.ammo.magazineCapacity = 1
		fireData.ammo.numberOfMagazines = -1

		fireData.weaponDispersion.standDispersion.minAngle = 20
		fireData.weaponDispersion.standDispersion.maxAngle = 20
		fireData.weaponDispersion.standDispersion.increasePerShot = 100
		fireData.weaponDispersion.crouchDispersion.minAngle = 10
		fireData.weaponDispersion.crouchDispersion.maxAngle = 10
		fireData.weaponDispersion.crouchDispersion.increasePerShot = 100
		fireData.weaponDispersion.proneDispersion.minAngle = 1.5
		fireData.weaponDispersion.proneDispersion.maxAngle = 1.5
		fireData.weaponDispersion.proneDispersion.increasePerShot = 100
		
		local bulletData = BulletEntityData(fireData.shot.projectileData)
		bulletData:MakeWritable()
		bulletData.gravity = -9.8
		bulletData.startDamage = 69
		bulletData.endDamage = 69
		bulletData.damageFalloffStartDistance = 0
		bulletData.damageFalloffEndDistance = 0
		print('Changed Spas-12...')
	end

	if (mmResources:IsLoaded('jackhammer')) then
		mmResources:SetLoaded('jackhammer', false)

		local weaponBP = SoldierWeaponBlueprint(mmResources:GetInstance('jackhammer'))
		local weaponData = SoldierWeaponData(weaponBP.object)

		for i=1, #weaponData.weaponModifierData do
			local weaponModData = WeaponModifierData(weaponData.weaponModifierData[i])
			local unlockAsset = UnlockAsset(weaponModData.unlockAsset)
			if (unlockAsset.name == 'Gameplay/XP2/GM_Deploytime') then
				for j=1, #weaponModData.modifiers do
					local unlockMod = weaponModData.modifiers[j]
					if (unlockMod:Is('WeaponMagazineModifier')) then
						local magMod = WeaponMagazineModifier(unlockMod)
						magMod:MakeWritable()
						magMod.magazineCapacity = 87
					end
				end
			end
		end

		local fireData = {
			FiringFunctionData(mmResources:GetInstance('jackhammer', 'FireFunction1')),
			FiringFunctionData(mmResources:GetInstance('jackhammer', 'FireFunction2')),
			FiringFunctionData(mmResources:GetInstance('jackhammer', 'FireFunction3')),
			FiringFunctionData(mmResources:GetInstance('jackhammer', 'FireFunction4'))
		}

		for i=1, #fireData do
			fireData[i]:MakeWritable()
			fireData[i].fireLogic.recoil.maxRecoilAngleX = 180
	        fireData[i].fireLogic.recoil.minRecoilAngleX = -180
	        fireData[i].fireLogic.recoil.maxRecoilAngleY = 180
	        fireData[i].fireLogic.recoil.minRecoilAngleY = -180
	        fireData[i].fireLogic.recoil.maxRecoilAngleZ = 180
	        fireData[i].fireLogic.recoil.minRecoilAngleZ = -180
			fireData[i].fireLogic.rateOfFire = 600

			fireData[i].ammo.magazineCapacity = 87
			fireData[i].ammo.numberOfMagazines = 8
		end

		fireData[1].shot.numberOfBulletsPerShell = 45 -- pellets
		fireData[2].shot.numberOfBulletsPerShell = 45 -- flechets
		fireData[3].shot.numberOfBulletsPerShell = 10 -- frags
		fireData[4].shot.numberOfBulletsPerShell = 10 -- slugs

		print('Changed Jackhammer...')
	end

	if (mmResources:IsLoaded('acwr') and mmResources:IsLoaded('acwrbullets')) then
		mmResources:SetLoaded('acwr', false)
		mmResources:SetLoaded('acwrbullets', false)

		local weaponBP = SoldierWeaponBlueprint(mmResources:GetInstance('acwr'))
		local weaponData = SoldierWeaponData(weaponBP.object)

		for i=1, #weaponData.weaponModifierData do
			local weaponModData = WeaponModifierData(weaponData.weaponModifierData[i])
			local unlockAsset = UnlockAsset(weaponModData.unlockAsset)
			if (unlockAsset.name == 'Gameplay/XP2/GM_Deploytime') then
				for j=1, #weaponModData.modifiers do
					local unlockMod = weaponModData.modifiers[j]
					if (unlockMod:Is('WeaponMagazineModifier')) then
						local magMod = WeaponMagazineModifier(unlockMod)
						magMod:MakeWritable()
						magMod.magazineCapacity = 9001
					end
				end
			end
		end

		local fireData = FiringFunctionData(weaponData.weaponFiring.primaryFire)
		fireData:MakeWritable()
		fireData.shot.initialSpeed.z = 380
		fireData.shot.numberOfBulletsPerShell = 1
		fireData.fireLogic.rateOfFire = 1200
		fireData.ammo.magazineCapacity = 9001
		fireData.ammo.numberOfMagazines = -1
		
		local bulletData = BulletEntityData(mmResources:GetInstance('acwrbullets'))
		bulletData:MakeWritable()
		bulletData.gravity = -9.8
		bulletData.startDamage = 187
		bulletData.endDamage = 5000
		bulletData.damageFalloffStartDistance = 10
		bulletData.damageFalloffEndDistance = 500
		print('Changed ACW-R...')
	end



	if (mmResources:IsLoaded('ammobag')) then
		mmResources:SetLoaded('ammobag', false)

		local supplySphereData = SupplySphereEntityData(mmResources:GetInstance('ammobag'))
		supplySphereData:MakeWritable()
		supplySphereData.receivesExplosionDamage = false

		supplySphereData.supplyData.ammo.radius = 9000
		supplySphereData.supplyData.ammo.supplyIncSpeed = 1
		supplySphereData.supplyData.ammo.infiniteCapacity = true
		supplySphereData.supplyData.ammo.supplyPointsRefillSpeed = 1
		supplySphereData.supplyData.ammo.supplyPointsCapacity = 1

		print('Changed Ammobag...')
	end

	if (mmResources:IsLoaded('grenade')) then
		mmResources:SetLoaded('grenade', false)

		local fireData = FiringFunctionData(mmResources:GetInstance('grenade'))
		fireData:MakeWritable()
		
		fireData.weaponDispersion.standDispersion.minAngle = 3.5
		fireData.weaponDispersion.standDispersion.maxAngle = 5
		fireData.weaponDispersion.standDispersion.increasePerShot = 0.8
		fireData.weaponDispersion.crouchDispersion.minAngle = 3.5
		fireData.weaponDispersion.crouchDispersion.maxAngle = 5
		fireData.weaponDispersion.crouchDispersion.increasePerShot = 0.8
		fireData.weaponDispersion.proneDispersion.minAngle = 3.5
		fireData.weaponDispersion.proneDispersion.maxAngle = 5
		fireData.weaponDispersion.proneDispersion.increasePerShot = 0.8

		fireData.shot.initialSpeed.z = 15
		fireData.shot.numberOfBulletsPerShell = 10
		fireData.shot.numberOfBulletsPerShot = 10

		fireData.ammo.magazineCapacity = 1
		fireData.ammo.numberOfMagazines = 10
		fireData.ammo.ammoBagPickupDelayMultiplier = 10
		print('Changed M67 Grenade...')
	end

	if (mmResources:IsLoaded('grenadeent')) then
		mmResources:SetLoaded('grenadeent', false)

		local grenadeData = GrenadeEntityData(mmResources:GetInstance('grenadeent'))
		grenadeData:MakeWritable()

		grenadeData.transform.left.x = 4
		grenadeData.transform.up.y = 4
		grenadeData.transform.forward.z = 4

		grenadeData.timeToLive = 1
		grenadeData.gravity = -30
		print('Changed M67 Grenade Entity...')
	end

	if (mmResources:IsLoaded('grenadeexp')) then
		mmResources:SetLoaded('grenadeexp', false)

		local expData = VeniceExplosionEntityData(mmResources:GetInstance('grenadeexp'))
		expData:MakeWritable()
		expData.blastDamage = 133
		expData.blastRadius = 4
		expData.blastImpulse = 0
		expData.shockwaveDamage = 0.1
		expData.shockwaveRadius = 3
		expData.shockwaveImpulse = 0
		expData.shockwaveTime = 0
		expData.triggerImpairedHearing = false
		expData.isCausingSuppression = false
		print('Changed M67 Grenade Explosion...')
	end

	if (mmResources:IsLoaded('m60') and mmResources:IsLoaded('crossbolt_he') and mmResources:IsLoaded('crossboltsound')) then
		mmResources:SetLoaded('m60', false)
		mmResources:SetLoaded('crossbolt_he', false)
		mmResources:SetLoaded('crossboltsound', false)
		-- swap m60 for crossbolt_he bullets
		local fireData = FiringFunctionData(mmResources:GetInstance('m60'))
		local bulletData = BulletEntityData(mmResources:GetInstance('crossbolt_he'))

		bulletData:MakeWritable()
		bulletData.gravity = -4.5
		bulletData.startDamage = 100
		bulletData.endDamage = 9001
		bulletData.damageFalloffStartDistance = 25
		bulletData.damageFalloffEndDistance = 500
		bulletData.timeToLive = 15
		bulletData.impactImpulse = -50000
		print('Changed Crossbow Bolt HE Projectile...')

		fireData:MakeWritable()
		fireData.sound = SoundPatchAsset(mmResources:GetInstance('crossboltsound'))
		fireData.shot.projectileData:MakeWritable()
		fireData.shot.projectileData = ProjectileEntityData(bulletData)
		fireData.shot.initialSpeed.z = 45
		fireData.ammo.magazineCapacity = 20
		fireData.fireLogic.reloadTime = 3.7
		print('Changed M60...')
	end

	if (mmResources:IsLoaded('m98')) then
		mmResources:SetLoaded('m98', false)

		local fireData = FiringFunctionData(mmResources:GetInstance('m98'))
		fireData:MakeWritable()
		fireData.shot.initialSpeed.z = 9001
		print('Changed M98 FireData...')
	end

	if (mmResources:IsLoaded('bullet338')) then
		mmResources:SetLoaded('bullet338', false)

		local bulletData = BulletEntityData(mmResources:GetInstance('bullet338'))
		bulletData:MakeWritable()
		bulletData.timeToLive = 1.5
		bulletData.startDamage = 69420
		bulletData.endDamage = 69420
		bulletData.damageFalloffStartDistance = 9000
		bulletData.damageFalloffEndDistance = 9001
		print('Changed M98 Bullet...')
	end

	if (mmResources:IsLoaded('rpgprojectile') and mmResources:IsLoaded('aek971')) then
		mmResources:SetLoaded('rpgprojectile', false)
		mmResources:SetLoaded('aek971', false)
		-- swap aek bullet for rpg rocket
		local fireData = FiringFunctionData(mmResources:GetInstance('aek971'))
		fireData:MakeWritable()
		fireData.ammo.numberOfMagazines = 20
		fireData.shot.projectileData:MakeWritable()
		fireData.shot.projectileData = ProjectileEntityData(mmResources:GetInstance('rpgprojectile'))
		print('Changed AEK Projectile...')
	end

	if (mmResources:IsLoaded('c4')) then
		mmResources:SetLoaded('c4', false)

		local fireData = FiringFunctionData(mmResources:GetInstance('c4'))
		fireData:MakeWritable()
		fireData.ammo.numberOfMagazines = 25
		fireData.ammo.autoReplenishDelay = 0.1
		fireData.ammo.ammoBagPickupDelayMultiplier = 0.1

		fireData.fireLogic.rateOfFire = 350.0
		print('Changed C4...')
	end

	if (mmResources:IsLoaded('c4expentity')) then
		mmResources:SetLoaded('c4expentity', false)

		local expEntityData = ExplosionPackEntityData(mmResources:GetInstance('c4expentity'))
		expEntityData:MakeWritable()
		expEntityData.health = 1
		expEntityData.maxCount = 25
		print('Changed C4 Entity...')
	end

	if (mmResources:IsLoaded('c4exp')) then
		mmResources:SetLoaded('c4exp', false)

		local expData = VeniceExplosionEntityData(mmResources:GetInstance('c4exp'))
		expData:MakeWritable()
		expData.blastDamage = 25
		expData.blastRadius = 14
		expData.blastImpulse = 1987
		expData.shockwaveDamage = 10
		expData.shockwaveRadius = 10
		expData.shockwaveImpulse = 1987
		expData.shockwaveTime = 0.15
		expData.triggerImpairedHearing = false
		expData.isCausingSuppression = false
		print('Changed C4 Explosion...')
	end

	if (mmResources:IsLoaded('knoife')) then
		mmResources:SetLoaded('knoife', false)

		local meleeData = MeleeEntityCommonData(mmResources:GetInstance('knoife'))
		meleeData:MakeWritable()
		meleeData.meleeAttackDistance = 5
		meleeData.maxAttackHeightDifference = 5
		meleeData.invalidMeleeAttackZone = 10
		print('Changed Knoife (Knife)...')
	end

	if (mmResources:IsLoaded('famas')) then
		mmResources:SetLoaded('famas', false)

		local fireData = FiringFunctionData(mmResources:GetInstance('famas'))
		fireData:MakeWritable()
		fireData.ammo.magazineCapacity = 1001
		fireData.shot.numberOfBulletsPerBurst = 25
		fireData.fireLogic.rateOfFire = 4500
		fireData.fireLogic.rateOfFireForBurst = 7500
		print('Changed Famas...')
	end
end

function MMWeapons:onShared_FamasMagSize( player, args )
	mmResources:SetLoaded('famas', true)
	self:Write(mmResources)
end

function MMWeapons:onShared_KnoifeRange( player, args )
	mmResources:SetLoaded('knoife', true)
	self:Write(mmResources)
end

function MMWeapons:onShared_FamasRoF( player, args )
	mmResources:SetLoaded('famas', true)
	self:Write(mmResources)
end

function MMWeapons:onShared_MinePower( player, args )
	mmResources:SetLoaded('m15exp', true)
	self:Write(mmResources)
end

return MMWeapons()
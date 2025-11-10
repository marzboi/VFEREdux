local function toggleLaserState(weapon, character)
	if not weapon or not character then return end

	local canon = weapon:getWeaponPart("Canon")
	if not canon then return end

	local newPart = nil
	if character:isAiming() and canon:getFullType() == "Base.Laser" then
		newPart = instanceItem("Base.LaserOn")
	elseif not character:isAiming() and canon:getFullType() == "Base.LaserOn" then
		newPart = instanceItem("Base.Laser")
	end


	if newPart then
		weapon:detachWeaponPart(canon)
		weapon:attachWeaponPart(newPart)

		character:setPrimaryHandItem(weapon)
		if weapon:isTwoHandWeapon() then
			character:setSecondaryHandItem(weapon)
		end

		character:resetEquippedHandsModels()
		character:resetModelNextFrame()
	end
end

local function WeaponLightBeam()
	local character = getSpecificPlayer(0)
	if not character then return end

	local weapon = character:getPrimaryHandItem()
	if not weapon or not instanceof(weapon, "HandWeapon") then return end
	if weapon:getSubCategory() ~= "Firearm" then return end

	toggleLaserState(weapon, character)
end

Events.OnPlayerUpdate.Add(WeaponLightBeam)

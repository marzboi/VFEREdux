local function tryAttachPart(weapon, part, player)
	if part and part:canAttach(player, weapon) then
		weapon:attachWeaponPart(player, part)
	elseif player and part then
		player:getInventory():AddItem(part)
	end
end

local function copyModData(source, target)
	local targetData = target:getModData()
	for k, v in pairs(source:getModData()) do
		targetData[k] = v
	end
end

local function transferWeaponParts(source, target, character)
	local parts = source:getAllWeaponParts()
	for i = 1, parts:size() do
		tryAttachPart(target, parts:get(i - 1), character)
	end
end

local function equipWeapon(character, originalWeapon, newWeapon)
	if not character or not newWeapon then return end

	local wasPrimary = (character:getPrimaryHandItem() == originalWeapon)
	local wasSecondary = (character:getSecondaryHandItem() == originalWeapon)

	if wasSecondary then
		character:setSecondaryHandItem(newWeapon)
	end
	if wasPrimary then
		character:setPrimaryHandItem(newWeapon)
	elseif wasSecondary and not character:getPrimaryHandItem() then
		character:setPrimaryHandItem(newWeapon)
	end
end

function Recipe.OnCreate.UseWeaponAlternate(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems()
	local result = craftRecipeData:getAllCreatedItems():get(0)

	for i = 0, items:size() - 1 do
		local item = items:get(i)
		if item:getSubCategory() == "Firearm" then
			copyModData(item, result)
			transferWeaponParts(item, result, character)
			equipWeapon(character, item, result)
			return
		end
	end
end

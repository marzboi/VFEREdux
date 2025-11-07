local function manageMagazineAttachment(weapon, character, shouldAttach)
	if not weapon then return end

	if shouldAttach then
		local Magazine = instanceItem("MagazineAttachment")
		if Magazine then
			weapon:attachWeaponPart(instanceItem("MagazineAttachment"), true)
		end
	else
		local Magazine = weapon:getWeaponPart("Clip")
		if Magazine and character then
			weapon:detachWeaponPart(character, weapon:getWeaponPart("Clip"))
		end
	end
end

local ISInsertMagazine_complete_old = ISInsertMagazine.complete
function ISInsertMagazine:complete()
	manageMagazineAttachment(self.gun, nil, true)
	ISInsertMagazine_complete_old(self)
end

local ISEjectMagazine_complete_old = ISEjectMagazine.complete
function ISEjectMagazine:complete()
	manageMagazineAttachment(self.gun, self.character, false)
	ISEjectMagazine_complete_old(self)
end

-- local function ISAttachMagazine(wielder, weapon)
-- 	if not weapon or not weapon:IsWeapon() or not weapon:isRanged() then
-- 		return
-- 	end

-- 	local magazineType = weapon:getMagazineType()
-- 	if not magazineType then
-- 		return
-- 	end

-- 	manageMagazineAttachment(weapon, wielder, weapon:isContainsClip())
-- end

-- Events.OnEquipPrimary.Add(ISAttachMagazine)

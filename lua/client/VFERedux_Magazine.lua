local function manageMagazineAttachment(weapon, shouldAttach)
	if not weapon then return end
	local part = weapon:getWeaponPart('Sling')
	local coupled556 = part and
		(part:getFullType() == 'Base.Coupled556' or part:getFullType() == 'Base.Coupled556_Hidden')
	local coupled762 = part and
		(part:getFullType() == 'Base.Coupled762' or part:getFullType() == 'Base.Coupled762_Hidden')


	if shouldAttach then
		local Magazine = instanceItem("MagazineAttachment")
		if Magazine then
			weapon:attachWeaponPart(instanceItem("MagazineAttachment"), true)

			if coupled556 then
				weapon:attachWeaponPart(instanceItem("Base.Coupled556"), true)
			end

			if coupled762 then
				weapon:attachWeaponPart(instanceItem("Base.Coupled762"), true)
			end
		end
	else
		local Magazine = weapon:getWeaponPart("Clip")
		if Magazine then
			weapon:detachWeaponPart(weapon:getWeaponPart("Clip"))

			if coupled556 then
				weapon:attachWeaponPart(instanceItem("Base.Coupled556_Hidden"), true)
			end

			if coupled762 then
				weapon:attachWeaponPart(instanceItem("Base.Coupled762_Hidden"), true)
			end
		end
	end
end

local ISInsertMagazine_complete_old = ISInsertMagazine.complete
function ISInsertMagazine:complete()
	manageMagazineAttachment(self.gun, true)
	ISInsertMagazine_complete_old(self)
end

local ISEjectMagazine_complete_old = ISEjectMagazine.complete
function ISEjectMagazine:complete()
	manageMagazineAttachment(self.gun, false)
	ISEjectMagazine_complete_old(self)
end

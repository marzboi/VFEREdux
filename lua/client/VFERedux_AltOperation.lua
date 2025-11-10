require "ISUI/ISInventoryPaneContextMenu"

VFEAltOperationContext = {}

VFEAltOperationContext.callAction = function(item, altOperation, target, player) --when you click the action this gets called first
	--if stuff not in main inv grab them
	local equipped = true
	if player:getPrimaryHandItem() ~= item or player:getSecondaryHandItem() ~= item then
		equipped = false
		ISTimedActionQueue.add(ISEquipWeaponAction:new(player, item, 50, true, true));
	end
	if item and item:getContainer() == player:getInventory() then
		if altOperation.Time > 0 then
			ISTimedActionQueue.add(VFEAltOperationAction:new(item, altOperation, target, player,
				CharacterActionAnims.Craft, altOperation.Time))
		else
			if equipped then
				VFEAltOperation(item, altOperation, target, player)
			else
				ISTimedActionQueue.add(VFEAltOperationAction:new(item, altOperation, target, player,
					CharacterActionAnims.Craft, 1.0))
			end
		end
	end
end

--------------  Timed Action
VFEAltOperationAction = ISBaseTimedAction:derive("VFEAltOperationAction");

function VFEAltOperationAction:new(item, altOperation, target, character, anim, time) --definition
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.item = item;
	o.altOperation = altOperation;
	o.target = target;
	o.stopOnWalk = false;
	o.stopOnRun = true;
	o.maxTime = time;
	o.caloriesModifier = 6;
	o.animation = anim
	o.useProgressBar = false;
	if character:isTimedActionInstant() then
		o.maxTime = 1;
	end
	return o;
end

function VFEAltOperationAction:isValid() --if items move or get deleted abort the action
	local returnvalue = true
	if not self.item or self.item:getContainer() ~= self.character:getInventory() then
		returnvalue = false;
	end
	return returnvalue;
end

function VFEAltOperationAction:waitToStart()
	return false;
end

function VFEAltOperationAction:start() -- when it starts
	self.item:setJobType(self.altOperation.ActionText);
	self.item:setJobDelta(0.0);
	self:setOverrideHandModels(self.item:getStaticModel(), nil)
	self:setActionAnim(self.animation);
end

function VFEAltOperationAction:perform() --the action itself, gets called when it's completed
	VFEAltOperation(self.item, self.altOperation, self.target, self.character)

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function VFEAltOperationAction:update()
	self.item:setJobDelta(self:getJobDelta());
	self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function VFEAltOperationAction:stop()
	ISBaseTimedAction.stop(self);
	self.item:setJobDelta(0.0);
end

local function AltOperationModifierRecalc(item)
	item:getModData().scriptStats = {
		ScriptName = item:getDisplayName() or "",
		MinDamage = item:getMinDamage() or nil,
		MaxDamage = item:getMaxDamage() or nil,
		TreeDamage = item:getTreeDamage() or nil,
		DoorDamage = item:getDoorDamage() or nil,
		PushBackMod = item:getPushBackMod() or nil,
		KnockdownMod = item:getKnockdownMod() or nil,
		MaxRange = item:getMaxRange() or nil,
		MinRange = item:getMinRange() or nil,
		BaseSpeed = item:getBaseSpeed() or nil,
		EnduranceMod = item:getEnduranceMod() or nil,
		CriticalChance = item:getCriticalChance() or nil,
		ConditionLowerChance = item:getConditionLowerChance() or nil,
		HitChance = item:getHitChance() or nil,
		SoundRadius = item:getSoundRadius() or nil,
		SoundVolume = item:getSoundVolume() or nil,
		SoundGain = item:getSoundGain() or nil,
		RecoilDelay = item:getRecoilDelay() or nil,
		AimingTime = item:getAimingTime() or nil,
		ReloadTime = item:getReloadTime() or nil,
		AimingPerkRangeModifier = item:getAimingPerkRangeModifier() or nil,
		AimingPerkCritModifier = item:getAimingPerkCritModifier() or nil,
		AimingPerkHitChanceModifier = item:getAimingPerkHitChanceModifier() or nil,
	}
end


function VFEAltOperation(item, altOperation, target, player)
	local result = player:getInventory():AddItem(altOperation.Name[target])
	local hotBar = getPlayerHotbar(player:getPlayerNum())

	result:setBloodLevel(item:getBloodLevel())
	result:setActivated(item:isActivated())
	result:setFavorite(item:isFavorite())

	local modData = result:getModData() -- Mod Data
	for k, v in pairs(item:getModData()) do
		modData[k] = v
	end

	if altOperation.CombinationWeapon then
		if modData.weapon == nil then
			modData.weapon = {}
		end
		if modData.weapon[1] == nil then
			modData.weapon[1] = {}
		end
		if modData.weapon[2] == nil then
			modData.weapon[2] = {}
		end

		-- Save and load the alternative configurations
		if result:haveChamber() and modData.weapon[target].isRoundChambered then -- Chamber Check
			result:setRoundChambered(true)
		elseif result:haveChamber() and not modData.weapon[target].isRoundChambered then
			result:setRoundChambered(false)
		end
		if item:haveChamber() then -- Chamber Check
			if item:isRoundChambered() then
				modData.weapon[3 - target].isRoundChambered = true
			else
				modData.weapon[3 - target].isRoundChambered = flase
			end
		end
		if modData.weapon[target].isJammed then
			result:setJammed(modData.weapon[target].isJammed)
		end
		modData.weapon[3 - target].isJammed = item:isJammed()
		if modData.weapon[target].isContainsClip then
			result:setContainsClip(modData.weapon[target].isContainsClip)
		end
		modData.weapon[3 - target].isContainsClip = item:isContainsClip()
		if modData.weapon[target].spentAmmoCount then
			result:setSpentRoundCount(modData.weapon[target].spentAmmoCount)
		end
		modData.weapon[3 - target].spentAmmoCount = item:getSpentRoundCount()
		if modData.weapon[target].ammoCount then
			result:setCurrentAmmoCount(modData.weapon[target].ammoCount)
		end
		modData.weapon[3 - target].ammoCount = item:getCurrentAmmoCount()
		if altOperation.SeperateDurability then
			modData.weapon[3 - target].roundsNoJam = modData.roundsNoJam
			modData.roundsNoJam = modData.weapon[target].roundsNoJam
			if modData.weapon[target].condition then
				result:setCondition(modData.weapon[target].condition)
			end
			modData.weapon[3 - target].condition = item:getCondition()
			if modData.weapon[target].repaired then
				result:setHaveBeenRepaired(modData.weapon[target].repaired)
			end
			modData.weapon[3 - target].repaired = item:getHaveBeenRepaired()
		else
			result:setCondition(item:getCondition())
			result:setHaveBeenRepaired(item:getHaveBeenRepaired())
		end

		-- Weight conserving attachmant manager ignore if not defined
		if altOperation.CombinationAmmo ~= nil then
			-- Remove clip from the weapon so later it doesn't magically come back
			local clip = item:getWeaponPart("Clip")
			if clip then
				item:detachWeaponPart(clip)
			end
			local partstring = altOperation.CombinationAmmo[3 - target]
			local ammoCount = 0
			local clipString
			if item:isRoundChambered() then ammoCount = 1 end
			ammoCount = ammoCount + item:getCurrentAmmoCount()
			if item:isContainsClip() then
				clipString = altOperation.CombinationMagazine[3 - target]
			else
				clipString =
				"NoClip"
			end
			local stringOutput = partstring .. clipString .. "_" .. ammoCount
			if ammoCount > 0 or clipString ~= "NoClip" then
				clip = instanceItem(stringOutput)
				result:attachWeaponPart(clip)
			end
		end
	else
		result:setCondition(item:getCondition())
		result:setHaveBeenRepaired(item:getHaveBeenRepaired())
		if result:haveChamber() and item:isRoundChambered() then -- Chamber Check
			result:setRoundChambered(true)
		end
		if item:isSpentRoundChambered() then
			result:setSpentRoundChambered(true)
		end
		if item:isJammed() then -- Jam check
			result:setJammed(true)
		end
		if item:isContainsClip() then
			result:setContainsClip(true)
		end
		result:setCurrentAmmoCount(item:getCurrentAmmoCount())
		result:setSpentRoundCount(item:getSpentRoundCount())

		result:setFireMode(item:getFireMode())
	end

	-- This doesn't work with a for loop for some reason
	local clip = item:getWeaponPart("Clip")
	local scope = item:getWeaponPart("Scope")
	local sling = item:getWeaponPart("Sling")
	local canon = item:getWeaponPart("Canon")
	local stock = item:getWeaponPart("Stock")
	local pad = item:getWeaponPart("RecoilPad")
	if scope then
		result:attachWeaponPart(scope)
	end
	if sling then
		result:attachWeaponPart(sling)
	end
	if canon then
		result:attachWeaponPart(canon)
	end
	if stock then
		result:attachWeaponPart(stock)
	end
	if pad then
		result:attachWeaponPart(pad)
	end
	if clip then
		result:attachWeaponPart(clip)
	end

	if hotBar:isInHotbar(item) then -- hotbar
		local itemSlot = item:getAttachedSlot()
		hotBar:removeItem(item, false)
		local slotDef = hotBar.availableSlot[itemSlot].def
		hotBar:attachItem(result, slotDef.attachments[result:getAttachmentType()], itemSlot, slotDef, false)

		hotBar.needsRefresh = true
		hotBar:update()
	end

	VFESetWeaponModel(result, false) -- Sets the model corretly incase of attachments that change weapon model
	VFESetWeaponIcon(result)

	player:getInventory():DoRemoveItem(item)
	player:setPrimaryHandItem(result);
	if result:isTwoHandWeapon() then
		player:setSecondaryHandItem(result);
	end
	-- If the weapon has a modifier, give it new base stats
	if (modData.modifier) then
		AltOperationModifierRecalc(result)
	end
	if altOperation.Sound ~= "NIL" then
		player:getEmitter():playSound(altOperation.Sound)
	end
end

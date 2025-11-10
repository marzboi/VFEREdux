-- TIS's code

require "ISUI/ISFirearmRadialMenu"
require "VFE_FoldingStock"

-----

local BaseCommand = ISBaseObject:derive("BaseCommand")

function BaseCommand:new(frm)
	local o = ISBaseObject.new(self)
	o.frm = frm
	o.character = frm.character
	o.index = 0
	return o
end

function BaseCommand:getWeapon()
	return self.frm:getWeapon()
end

function BaseCommand:fillMenu(menu, weapon, index)
	error "forgot to derive fillMenu()"
end

----- VFE Code

local CVFEFoldingStock = BaseCommand:derive("CVFEFoldingStock")

function CVFEFoldingStock:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CVFEFoldingStock:fillMenu(menu, weapon, index)
	if (index % 2 == 1) then
		self.index = index + 1
		local text = getText("IGUI_FirearmRadial_FoldStock")
		menu:addSlice(text, getTexture("media/ui/RadialMenu_FoldStock.png"), self.invoke, self)
	else
		self.index = index - 1
		local text = getText("IGUI_FirearmRadial_UnfoldStock")
		menu:addSlice(text, getTexture("media/ui/RadialMenu_UnfoldStock.png"), self.invoke, self)
	end
end

function CVFEFoldingStock:invoke()
	local weapon = self:getWeapon()
	if not weapon then return end
	ISTimedActionQueue.add(VFEStockContextAction:new(weapon, self.index, self.character, CharacterActionAnims.Craft, 15));
end

-----

local CVFEBayonet = BaseCommand:derive("CVFEBayonet")

function CVFEBayonet:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CVFEBayonet:fillMenu(menu, weapon, index)
	local bayonet = nil
	local bayonetFound = false
	self.index = index
	local parts = weapon:getAllWeaponParts()
	for i = 1, parts:size() do
		if parts:get(i - 1):hasTag("BlockBayonet") then
			return
		end
	end
	if index % 3 == 1 then
		if VFEBayonetSet[index + 2] ~= "NULL" then
			local playerItems = self.character:getInventory():getItems()
			for i = 1, playerItems:size() do
				bayonet = playerItems:get(i - 1)
				if bayonet:getFullType() == VFEBayonetSet[index + 2] and not bayonet:isBroken() then
					bayonetFound = true
					break
				end
			end
			if not bayonetFound then return end
		end
	end

	if weapon:getSubCategory() == "Firearm" then
		local text = getText("IGUI_FirearmRadial_UseBayonet")
		menu:addSlice(text, getTexture("media/ui/RadialMenu_UseBayonet.png"), self.invoke, self)
	else
		local text = getText("IGUI_FirearmRadial_UseRifle")
		menu:addSlice(text, getTexture("media/ui/RadialMenu_UseRifle.png"), self.invoke, self)
	end
end

function CVFEBayonet:invoke()
	local weapon = self.character:getPrimaryHandItem()
	if not weapon then return end
	local bayonet = nil
	local bayonetFound = false
	if self.index % 3 == 1 then
		if VFEBayonetSet[self.index + 2] ~= "NULL" then
			bayonetScript = getScriptManager():getItem(VFEBayonetSet[self.index + 2])
			local playerItems = self.character:getInventory():getItems()
			for i = 1, playerItems:size() do
				bayonet = playerItems:get(i - 1)
				if bayonet:getFullType() == VFEBayonetSet[self.index + 2] and not bayonet:isBroken() then
					bayonetFound = true
					break
				end
			end
		else
			bayonetFound = true
		end
	else
		if VFEBayonetSet[self.index + 1] ~= "NULL" then
			bayonetScript = getScriptManager():getItem(VFEBayonetSet[self.index + 1])
		end
		bayonetFound = true
	end

	ISTimedActionQueue.add(VFEBayonetContextAction:new(weapon, self.index, self.character, bayonet,
		CharacterActionAnims.Craft, 15));
end

-----
local CVFEAltOperation = BaseCommand:derive("CVFEAltOperation")

function CVFEAltOperation:new(frm)
	local o = BaseCommand.new(self, frm)
	o.isAltOp = true
	return o
end

function CVFEAltOperation:fillMenu(menu, weapon, index)
	local altOperationList = VFEAltOperationSetCheck(weapon)

	if #altOperationList > 0 then
		if altOperationList[index].RadialMenu then
			local target = 2
			if altOperationList[index].Name[2] == weapon:getFullType() then
				target = 1
			end
			self.altOperation = altOperationList[index]
			self.target = target
			if altOperationList[index].RadialMenu then
				if altOperationList[index].RequireEmpty then
					if not (weapon:isContainsClip() and altOperationList[index].RequireNoMag) and not (weapon:getCurrentAmmoCount() > 0) and not weapon:isRoundChambered() then
						local text = getText(altOperationList[index].OperationText[target])
						menu:addSlice(text,
							getTexture("media/ui/" .. altOperationList[index].OperationIcon[target] .. ".png"),
							self.invoke, self)
					end
				else
					local text = getText(altOperationList[index].OperationText[target])
					menu:addSlice(text,
						getTexture("media/ui/" .. altOperationList[index].OperationIcon[target] .. ".png"), self.invoke,
						self)
				end
			end
		end
	end
end

function CVFEAltOperation:invoke()
	local weapon = self.character:getPrimaryHandItem()
	if not weapon then return end
	VFEAltOperationContext.callAction(weapon, self.altOperation, self.target, self.character)
end

--- because they're local I have to redefine all the other methods lmao --
-----

local CInsertMagazine = BaseCommand:derive("CInsertMagazine")

function CInsertMagazine:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CInsertMagazine:fillMenu(menu, weapon, index)
	if weapon:isContainsClip() then return end
	if not weapon:getMagazineType() then return end
	local magazine = weapon:getBestMagazine(self.character)
	if not magazine then return end
	local text = getText("IGUI_FirearmRadial_InsertMagazine")
	local xln = "IGUI_FirearmRadial_AmmoCount"
	local textCount = getText(xln, magazine:getCurrentAmmoCount(), magazine:getMaxAmmo())
	text = text .. '\n' .. textCount
	menu:addSlice(text, getTexture("media/ui/FirearmRadial_InsertMagazine.png"), self.invoke, self)
end

function CInsertMagazine:invoke()
	local weapon = self:getWeapon()
	if not weapon then return end
	if weapon:isContainsClip() then return end
	local magazine = weapon:getBestMagazine(self.character)
	if not magazine then return end
	ISInventoryPaneContextMenu.transferIfNeeded(self.character, magazine)
	ISTimedActionQueue.add(ISInsertMagazine:new(self.character, weapon, magazine))
end

-----

local CEjectMagazine = BaseCommand:derive("CEjectMagazine")

function CEjectMagazine:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CEjectMagazine:fillMenu(menu, weapon, index)
	if not weapon:isContainsClip() then return end
	local text = getText("IGUI_FirearmRadial_EjectMagazine")
	local xln = weapon:isRoundChambered() and "IGUI_FirearmRadial_AmmoCountChambered" or "IGUI_FirearmRadial_AmmoCount"
	local textCount = getText(xln, weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
	text = text .. '\n' .. textCount
	text = text:gsub("\\n", "\n")
	menu:addSlice(text, getTexture("media/ui/FirearmRadial_EjectMagazine.png"), self.invoke, self)
end

function CEjectMagazine:invoke()
	local weapon = self:getWeapon()
	if not weapon then return end
	if not weapon:isContainsClip() then return end
	ISTimedActionQueue.add(ISEjectMagazine:new(self.character, weapon))
end

-----

local CLoadBulletsInMagazine = BaseCommand:derive("CLoadBulletsInMagazine")

function CLoadBulletsInMagazine:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

local function predicateNotFullMagazine(item, magazineType)
	return (item:getType() == magazineType or item:getFullType() == magazineType) and
		item:getCurrentAmmoCount() < item:getMaxAmmo()
end

local function predicateFullestMagazine(item1, item2)
	return item1:getCurrentAmmoCount() - item2:getCurrentAmmoCount()
end

function CLoadBulletsInMagazine:getMagazine(weapon)
	if not weapon:getMagazineType() then return nil end
	local inventory = self.character:getInventory()
	return inventory:getBestEvalArgRecurse(predicateNotFullMagazine, predicateFullestMagazine, weapon:getMagazineType())
end

function CLoadBulletsInMagazine:hasBulletsForMagazine(magazine)
	local inventory = self.character:getInventory()
	return inventory:getCountTypeRecurse(magazine:getAmmoType()) > 0
end

function CLoadBulletsInMagazine:fillMenu(menu, weapon, index)
	local magazine = self:getMagazine(weapon)
	if not magazine then return end
	if not self:hasBulletsForMagazine(magazine) then return end
	local text = getText("IGUI_FirearmRadial_LoadBulletsIntoMagazine")
	local xln = "IGUI_FirearmRadial_AmmoCount"
	local textCount = getText(xln, magazine:getCurrentAmmoCount(), magazine:getMaxAmmo())
	text = text .. '\\n' .. textCount
	text = text:gsub('\\n', '\n')
	menu:addSlice(text, getTexture("media/ui/FirearmRadial_BulletsIntoMagazine.png"), self.invoke, self)
end

function CLoadBulletsInMagazine:invoke()
	local weapon = self:getWeapon()
	if not weapon then return end
	local magazine = self:getMagazine(weapon)
	if not magazine then return end
	if not self:hasBulletsForMagazine(magazine) then return end
	ISInventoryPaneContextMenu.transferIfNeeded(self.character, magazine)
	local ammoCount = ISInventoryPaneContextMenu.transferBullets(self.character, magazine:getAmmoType(),
		magazine:getCurrentAmmoCount(), magazine:getMaxAmmo())
	if ammoCount == 0 then return end
	ISTimedActionQueue.add(ISLoadBulletsInMagazine:new(self.character, magazine, ammoCount))
end

-----

local CLoadRounds = BaseCommand:derive("CLoadRounds")

function CLoadRounds:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CLoadRounds:hasBullets(weapon)
	local inventory = self.character:getInventory()
	return inventory:getCountTypeRecurse(weapon:getAmmoType()) > 0
end

function CLoadRounds:fillMenu(menu, weapon, index)
	if weapon:getMagazineType() then return end
	if weapon:getCurrentAmmoCount() >= weapon:getMaxAmmo() then return end
	if not self:hasBullets(weapon) then return end
	local text = getText("IGUI_FirearmRadial_LoadRounds")
	local xln = weapon:isRoundChambered() and "IGUI_FirearmRadial_AmmoCountChambered" or "IGUI_FirearmRadial_AmmoCount"
	local textCount = getText(xln, weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
	text = text .. '\\n' .. textCount
	text = text:gsub('\\n', '\n')
	menu:addSlice(text, getTexture("media/ui/FirearmRadial_BulletsIntoFirearm.png"), self.invoke, self)
end

function CLoadRounds:invoke()
	local weapon = self:getWeapon()
	if not weapon then return end
	if weapon:getMagazineType() then return end
	if weapon:getCurrentAmmoCount() >= weapon:getMaxAmmo() then return end
	if not self:hasBullets(weapon) then return end
	ISInventoryPaneContextMenu.transferBullets(self.character, weapon:getAmmoType(), weapon:getCurrentAmmoCount(),
		weapon:getMaxAmmo())
	ISTimedActionQueue.add(ISReloadWeaponAction:new(self.character, weapon))
end

-----

local CUnloadRounds = BaseCommand:derive("CUnloadRounds")

function CUnloadRounds:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CUnloadRounds:fillMenu(menu, weapon, index)
	if weapon:getMagazineType() then return end
	if weapon:getCurrentAmmoCount() == 0 then return end
	local text = getText("IGUI_FirearmRadial_UnloadRounds")
	local xln = weapon:isRoundChambered() and "IGUI_FirearmRadial_AmmoCountChambered" or "IGUI_FirearmRadial_AmmoCount"
	local textCount = getText(xln, weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
	text = text .. '\\n' .. textCount
	text = text:gsub('\\n', '\n')
	menu:addSlice(text, getTexture("media/ui/FirearmRadial_BulletsFromFirearm.png"), self.invoke, self)
end

function CUnloadRounds:invoke()
	local weapon = self:getWeapon()
	if not weapon then return end
	if weapon:getMagazineType() then return end
	if weapon:getCurrentAmmoCount() == 0 then return end
	ISTimedActionQueue.add(ISUnloadBulletsFromFirearm:new(self.character, weapon, false))
end

-----

local CRack = BaseCommand:derive("CRack")

function CRack:new(frm)
	local o = BaseCommand.new(self, frm)
	return o
end

function CRack:fillMenu(menu, weapon, index)
	if not ISReloadWeaponAction.canRack(weapon) then return end
	local xln = weapon:isRoundChambered() and "IGUI_FirearmRadial_AmmoCountChambered" or "IGUI_FirearmRadial_AmmoCount"
	local textCount = getText(xln, weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
	if weapon:isJammed() then
		local text = getText("IGUI_FirearmRadial_Unjam")
		text = text .. '\n' .. textCount
		menu:addSlice(text, getTexture("media/ui/FirearmRadial_Unjam.png"), self.invoke, self)
	elseif not weapon:haveChamber() or weapon:isRoundChambered() then
		local xln = weapon:haveChamber() and "IGUI_FirearmRadial_Rack" or "IGUI_FirearmRadial_UnloadRound"
		local text = getText(xln)
		text = text .. '\n' .. textCount
		menu:addSlice(text, getTexture("media/ui/FirearmRadial_Rack.png"), self.invoke, self)
	elseif weapon:haveChamber() then
		local text = getText("IGUI_FirearmRadial_ChamberRound")
		text = text .. '\n' .. textCount
		menu:addSlice(text, getTexture("media/ui/FirearmRadial_ChamberRound.png"), self.invoke, self)
	end
end

function CRack:invoke()
	local weapon = self:getWeapon()
	if not weapon then return end
	if not ISReloadWeaponAction.canRack(weapon) then return end
	ISTimedActionQueue.add(ISRackFirearm:new(self.character, weapon))
end

-----

local ISFirearmRadialMenu_fillMenu_old = ISFirearmRadialMenu.fillMenu
function ISFirearmRadialMenu:fillMenu(submenu)
	local weapon = self.character:getPrimaryHandItem()
	if not weapon then return nil end
	if not instanceof(weapon, "HandWeapon") then return nil end
	for index, preset in ipairs(VFEBayonetSet) do
		if preset == weapon:getFullType() and index % 3 == 2 then
			local weapInd = index
			local menu = getPlayerRadialMenu(self.playerNum)
			menu:clear()
			local commands = {}
			table.insert(commands, CVFEBayonet:new(self))

			for _, command in ipairs(commands) do
				local count = #menu.slices
				command:fillMenu(menu, weapon, weapInd)
				if count == #menu.slices then
					menu:addSlice(nil, nil, nil)
				end
			end
			return
		end
	end
	for index, preset in ipairs(VFEBayonetSet) do
		if preset == weapon:getFullType() and index % 3 == 1 then
			local weapInd = index
			local menu = getPlayerRadialMenu(self.playerNum)
			menu:clear()
			local commands = {}
			if weapon:getMagazineType() then
				if weapon:isContainsClip() then
					table.insert(commands, CEjectMagazine:new(self))
				else
					table.insert(commands, CInsertMagazine:new(self))
				end
				table.insert(commands, CLoadBulletsInMagazine:new(self))
			else
				table.insert(commands, CLoadRounds:new(self))
				table.insert(commands, CUnloadRounds:new(self))
			end
			table.insert(commands, CRack:new(self))
			table.insert(commands, CVFEBayonet:new(self))

			for _, command in ipairs(commands) do
				local count = #menu.slices
				command:fillMenu(menu, weapon, weapInd)
				if count == #menu.slices then
					menu:addSlice(nil, nil, nil)
				end
			end
			return
		end
	end
	for index, preset in ipairs(VFEFoldingWeaponPair) do
		if preset == weapon:getFullType() then
			local weapInd = index
			local menu = getPlayerRadialMenu(self.playerNum)
			menu:clear()
			local commands = {}
			if weapon:getMagazineType() then
				if weapon:isContainsClip() then
					table.insert(commands, CEjectMagazine:new(self))
				else
					table.insert(commands, CInsertMagazine:new(self))
				end
				table.insert(commands, CLoadBulletsInMagazine:new(self))
			else
				table.insert(commands, CLoadRounds:new(self))
				table.insert(commands, CUnloadRounds:new(self))
			end
			table.insert(commands, CRack:new(self))
			table.insert(commands, CVFEFoldingStock:new(self))

			for _, command in ipairs(commands) do
				local count = #menu.slices
				command:fillMenu(menu, weapon, weapInd)
				if count == #menu.slices then
					menu:addSlice(nil, nil, nil)
				end
			end
			return
		end
	end
	local altOperationList = VFEAltOperationSetCheck(weapon)
	if #altOperationList > 0 then
		local menu = getPlayerRadialMenu(self.playerNum)
		local weapInd = 1
		menu:clear()
		local commands = {}
		if weapon:getSubCategory() == "Firearm" then
			if weapon:getMagazineType() then
				if weapon:isContainsClip() then
					table.insert(commands, CEjectMagazine:new(self))
				else
					table.insert(commands, CInsertMagazine:new(self))
				end
				table.insert(commands, CLoadBulletsInMagazine:new(self))
			else
				table.insert(commands, CLoadRounds:new(self))
				table.insert(commands, CUnloadRounds:new(self))
			end
			table.insert(commands, CRack:new(self))
		end

		if #altOperationList > 0 then
			for index, altOperation in ipairs(altOperationList) do
				table.insert(commands, CVFEAltOperation:new(self))
			end
		end

		for _, command in ipairs(commands) do
			local count = #menu.slices
			command:fillMenu(menu, weapon, weapInd)
			if command.isAltOp == true then
				weapInd = weapInd + 1
			end
			if count == #menu.slices then
				menu:addSlice(nil, nil, nil)
			end
		end
		return
	end
	ISFirearmRadialMenu_fillMenu_old(self, submenu) -- If went through without finding a folding stock weapon or bayonet weapon, run the original script
end

local ISFirearmRadialMenu_checkWeapon_old = ISFirearmRadialMenu
	.checkWeapon -- Force bayonet guns into ranged weapon wheel
function ISFirearmRadialMenu.checkWeapon(playerObj)
	local weapon = playerObj:getPrimaryHandItem()
	if not weapon then return nil end
	for index, preset in ipairs(VFEBayonetSet) do
		if preset == weapon:getFullType() and index % 3 == 2 then
			return true
		end
	end
	-- Alt weapon operation
	local altOperationList = VFEAltOperationSetCheck(weapon)
	if #altOperationList > 0 then
		return true
	end
	return ISFirearmRadialMenu_checkWeapon_old(playerObj)
end

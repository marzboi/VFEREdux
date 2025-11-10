-- For weapons with alternative operation modes. Allows bipods, switching ammo types, and switching a combination gun's active weapon

--

VFEAltOperationSet = {}

-- Main function. Test for if weapon is in the list. if it is
function VFEAltOperationSetCheck(weapon)
	local weaponTables = {}
	for index, altOps in ipairs(VFEAltOperationSet) do
		if altOps.Name[1] == weapon:getFullType() or altOps.Name[2] == weapon:getFullType() then
			table.insert(weaponTables, altOps)
		end
	end
	return weaponTables
end

-- Mini tables contain the data for the operation
-- M2400 .308/Shotgun toggle
local M2400Combination = {}
M2400Combination.Name = {}
M2400Combination.Name[1] = "Base.M2400_Rifle"
M2400Combination.Name[2] = "Base.M2400_Shotgun"
M2400Combination.RequireEmpty = false
M2400Combination.RequireNoMag = false
M2400Combination.CombinationWeapon = true
M2400Combination.SeperateDurability = false
M2400Combination.CombinationAmmo = {}
M2400Combination.CombinationAmmo[1] = "VFECombination.Combination308"
M2400Combination.CombinationAmmo[2] = "VFECombination.CombinationShotgunShell"
M2400Combination.RadialMenu = true
M2400Combination.Time = 0
M2400Combination.Sound = "M16Jam"
M2400Combination.ActionText = "Switching Barrels"
M2400Combination.OperationText = {}
M2400Combination.OperationText[1] = "IGUI_FirearmRadial_AltUseRifle"
M2400Combination.OperationText[2] = "IGUI_FirearmRadial_AltUseShotgun"
M2400Combination.OperationIcon = {}
M2400Combination.OperationIcon[1] = "RadialMenu_M2400_UseRifle"
M2400Combination.OperationIcon[2] = "RadialMenu_M2400_UseShotgun"
table.insert(VFEAltOperationSet, M2400Combination);

-- Folding M60 Bipod
local M60Bipod = {}
M60Bipod.Name = {}
M60Bipod.Name[1] = "Base.M60MMG"
M60Bipod.Name[2] = "Base.M60MMG_Bipod"
M60Bipod.RequireEmpty = false
M60Bipod.RequireNoMag = false
M60Bipod.CombinationWeapon = false
M60Bipod.RadialMenu = true
M60Bipod.Time = 20
M60Bipod.Sound = "M16Equip"
M60Bipod.ActionText = "Moving Bipod"
M60Bipod.OperationText = {}
M60Bipod.OperationText[1] = "IGUI_FirearmRadial_AltFoldBipod"
M60Bipod.OperationText[2] = "IGUI_FirearmRadial_AltUnfoldBipod"
M60Bipod.OperationIcon = {}
M60Bipod.OperationIcon[1] = "RadialMenu_M60FoldBipod"
M60Bipod.OperationIcon[2] = "RadialMenu_M60UnfoldBipod"
table.insert(VFEAltOperationSet, M60Bipod);

-- M16 Masterkey
local AssaultRifleMasterkey = {}
AssaultRifleMasterkey.Name = {}
AssaultRifleMasterkey.Name[1] = "Base.AssaultRifleMasterkey"
AssaultRifleMasterkey.Name[2] = "Base.AssaultRifleMasterkeyShotgun"
AssaultRifleMasterkey.RequireEmpty = false
AssaultRifleMasterkey.CombinationWeapon = true
AssaultRifleMasterkey.SeperateDurability = true
AssaultRifleMasterkey.CombinationAmmo = {}
AssaultRifleMasterkey.CombinationAmmo[1] = "VFECombination.Combination556M16"
AssaultRifleMasterkey.CombinationAmmo[2] = "VFECombination.CombinationM500ShotgunShell"
AssaultRifleMasterkey.CombinationMagazine = {}
AssaultRifleMasterkey.CombinationMagazine[1] = "Magazine"
AssaultRifleMasterkey.CombinationMagazine[2] = "NoClip"
AssaultRifleMasterkey.RadialMenu = true
AssaultRifleMasterkey.Time = 0
AssaultRifleMasterkey.Sound = "NIL"
AssaultRifleMasterkey.ActionText = "Switching Weapons"
AssaultRifleMasterkey.OperationText = {}
AssaultRifleMasterkey.OperationText[1] = "IGUI_FirearmRadial_AltUseRifle"
AssaultRifleMasterkey.OperationText[2] = "IGUI_FirearmRadial_AltUseShotgun"
AssaultRifleMasterkey.OperationIcon = {}
AssaultRifleMasterkey.OperationIcon[1] = "RadialMenu_MasterkeyUseRifle"
AssaultRifleMasterkey.OperationIcon[2] = "RadialMenu_MasterkeyUseShotgun"
table.insert(VFEAltOperationSet, AssaultRifleMasterkey);

-- Entrenching Tool Blade-Fold
local EntrenchingToolSwap = {}
EntrenchingToolSwap.Name = {}
EntrenchingToolSwap.Name[1] = "Base.EntrenchingTool_Blade"
EntrenchingToolSwap.Name[2] = "Base.EntrenchingTool_Blunt"
EntrenchingToolSwap.RequireEmpty = false
EntrenchingToolSwap.RequireNoMag = false
EntrenchingToolSwap.CombinationWeapon = false
EntrenchingToolSwap.RadialMenu = true
EntrenchingToolSwap.Time = 10
EntrenchingToolSwap.Sound = "NIL"
EntrenchingToolSwap.ActionText = "Changing Grip"
EntrenchingToolSwap.OperationText = {}
EntrenchingToolSwap.OperationText[1] = "IGUI_FirearmRadial_AltUnfoldShovelBlade"
EntrenchingToolSwap.OperationText[2] = "IGUI_FirearmRadial_AltUnfoldShovelBlunt"
EntrenchingToolSwap.OperationIcon = {}
EntrenchingToolSwap.OperationIcon[1] = "RadialMenu_EntrenchingToolBlade"
EntrenchingToolSwap.OperationIcon[2] = "RadialMenu_EntrenchingToolBlunt"
table.insert(VFEAltOperationSet, EntrenchingToolSwap);

-- Entrenching Tool Blade-Fold
local EntrenchingToolBlade = {}
EntrenchingToolBlade.Name = {}
EntrenchingToolBlade.Name[1] = "Base.EntrenchingTool_Blade"
EntrenchingToolBlade.Name[2] = "Base.EntrenchingTool_Folded"
EntrenchingToolBlade.RequireEmpty = false
EntrenchingToolBlade.RequireNoMag = false
EntrenchingToolBlade.CombinationWeapon = false
EntrenchingToolBlade.RadialMenu = true
EntrenchingToolBlade.Time = 10
EntrenchingToolBlade.Sound = "NIL"
EntrenchingToolBlade.ActionText = "Folding Shovel"
EntrenchingToolBlade.OperationText = {}
EntrenchingToolBlade.OperationText[1] = "IGUI_FirearmRadial_AltUnfoldShovelBlade"
EntrenchingToolBlade.OperationText[2] = "IGUI_FirearmRadial_AltFoldShovel"
EntrenchingToolBlade.OperationIcon = {}
EntrenchingToolBlade.OperationIcon[1] = "RadialMenu_EntrenchingToolBlade"
EntrenchingToolBlade.OperationIcon[2] = "RadialMenu_EntrenchingToolFold"
table.insert(VFEAltOperationSet, EntrenchingToolBlade);

-- Entrenching Tool Blunt-Fold
local EntrenchingToolBlunt = {}
EntrenchingToolBlunt.Name = {}
EntrenchingToolBlunt.Name[1] = "Base.EntrenchingTool_Blunt"
EntrenchingToolBlunt.Name[2] = "Base.EntrenchingTool_Folded"
EntrenchingToolBlunt.RequireEmpty = false
EntrenchingToolBlunt.RequireNoMag = false
EntrenchingToolBlunt.CombinationWeapon = false
EntrenchingToolBlunt.RadialMenu = true
EntrenchingToolBlunt.Time = 10
EntrenchingToolBlunt.Sound = "NIL"
EntrenchingToolBlunt.ActionText = "Folding Shovel"
EntrenchingToolBlunt.OperationText = {}
EntrenchingToolBlunt.OperationText[1] = "IGUI_FirearmRadial_AltUnfoldShovelBlunt"
EntrenchingToolBlunt.OperationText[2] = "IGUI_FirearmRadial_AltFoldShovel"
EntrenchingToolBlunt.OperationIcon = {}
EntrenchingToolBlunt.OperationIcon[1] = "RadialMenu_EntrenchingToolBlunt"
EntrenchingToolBlunt.OperationIcon[2] = "RadialMenu_EntrenchingToolFold"
table.insert(VFEAltOperationSet, EntrenchingToolBlunt);

-- Entrenching Tool Blade-Fold
local EntrenchingToolSwap = {}
EntrenchingToolSwap.Name = {}
EntrenchingToolSwap.Name[1] = "Base.EntrenchingToolBlack_Blade"
EntrenchingToolSwap.Name[2] = "Base.EntrenchingToolBlack_Blunt"
EntrenchingToolSwap.RequireEmpty = false
EntrenchingToolSwap.RequireNoMag = false
EntrenchingToolSwap.CombinationWeapon = false
EntrenchingToolSwap.RadialMenu = true
EntrenchingToolSwap.Time = 10
EntrenchingToolSwap.Sound = "NIL"
EntrenchingToolSwap.ActionText = "Changing Grip"
EntrenchingToolSwap.OperationText = {}
EntrenchingToolSwap.OperationText[1] = "IGUI_FirearmRadial_AltUnfoldShovelBlade"
EntrenchingToolSwap.OperationText[2] = "IGUI_FirearmRadial_AltUnfoldShovelBlunt"
EntrenchingToolSwap.OperationIcon = {}
EntrenchingToolSwap.OperationIcon[1] = "RadialMenu_EntrenchingToolBlade"
EntrenchingToolSwap.OperationIcon[2] = "RadialMenu_EntrenchingToolBlunt"
table.insert(VFEAltOperationSet, EntrenchingToolSwap);

-- Entrenching Tool Blade-Fold
local EntrenchingToolBlade = {}
EntrenchingToolBlade.Name = {}
EntrenchingToolBlade.Name[1] = "Base.EntrenchingToolBlack_Blade"
EntrenchingToolBlade.Name[2] = "Base.EntrenchingToolBlack_Folded"
EntrenchingToolBlade.RequireEmpty = false
EntrenchingToolBlade.RequireNoMag = false
EntrenchingToolBlade.CombinationWeapon = false
EntrenchingToolBlade.RadialMenu = true
EntrenchingToolBlade.Time = 10
EntrenchingToolBlade.Sound = "NIL"
EntrenchingToolBlade.ActionText = "Folding Shovel"
EntrenchingToolBlade.OperationText = {}
EntrenchingToolBlade.OperationText[1] = "IGUI_FirearmRadial_AltUnfoldShovelBlade"
EntrenchingToolBlade.OperationText[2] = "IGUI_FirearmRadial_AltFoldShovel"
EntrenchingToolBlade.OperationIcon = {}
EntrenchingToolBlade.OperationIcon[1] = "RadialMenu_EntrenchingToolBlade"
EntrenchingToolBlade.OperationIcon[2] = "RadialMenu_EntrenchingToolFold"
table.insert(VFEAltOperationSet, EntrenchingToolBlade);

-- Entrenching Tool Blunt-Fold
local EntrenchingToolBlunt = {}
EntrenchingToolBlunt.Name = {}
EntrenchingToolBlunt.Name[1] = "Base.EntrenchingToolBlack_Blunt"
EntrenchingToolBlunt.Name[2] = "Base.EntrenchingToolBlack_Folded"
EntrenchingToolBlunt.RequireEmpty = false
EntrenchingToolBlunt.RequireNoMag = false
EntrenchingToolBlunt.CombinationWeapon = false
EntrenchingToolBlunt.RadialMenu = true
EntrenchingToolBlunt.Time = 10
EntrenchingToolBlunt.Sound = "NIL"
EntrenchingToolBlunt.ActionText = "Folding Shovel"
EntrenchingToolBlunt.OperationText = {}
EntrenchingToolBlunt.OperationText[1] = "IGUI_FirearmRadial_AltUnfoldShovelBlunt"
EntrenchingToolBlunt.OperationText[2] = "IGUI_FirearmRadial_AltFoldShovel"
EntrenchingToolBlunt.OperationIcon = {}
EntrenchingToolBlunt.OperationIcon[1] = "RadialMenu_EntrenchingToolBlunt"
EntrenchingToolBlunt.OperationIcon[2] = "RadialMenu_EntrenchingToolFold"
table.insert(VFEAltOperationSet, EntrenchingToolBlunt);

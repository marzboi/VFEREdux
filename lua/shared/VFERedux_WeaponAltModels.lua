VFEWeaponModelTable = {}

function VFESetWeaponModel(weapon, open)
	for index, modelfunction in ipairs(VFEWeaponModelTable) do
		if modelfunction.Name == weapon:getFullType() then
			modelfunction.Apply(weapon, open)
			return
		end
	end
	weapon:setWeaponSprite(weapon:getOriginalWeaponSprite())
end

local HuntingRifle = {}
HuntingRifle.Name = "Base.HuntingRifle"
HuntingRifle.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, HuntingRifle);

local VarmintRifle = {}
VarmintRifle.Name = "Base.VarmintRifle"
VarmintRifle.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, VarmintRifle);

local AK47 = {}
AK47.Name = "Base.AK47"
AK47.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		print(stock:getType() == "FiberglassStock")
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, AK47);

local MAK90 = {}
MAK90.Name = "Base.MAK90"
MAK90.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, MAK90);

local Mini14 = {}
Mini14.Name = "Base.Mini14"
Mini14.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, Mini14);


local SKS = {}
SKS.Name = "Base.SKS"
SKS.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, SKS);

local R1022 = {}
R1022.Name = "Base.1022"
R1022.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, R1022);

local AssaultRifle2 = {}
AssaultRifle2.Name = "Base.AssaultRifle2"
AssaultRifle2.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, AssaultRifle2);

local Shotgun = {}
Shotgun.Name = "Base.Shotgun"
Shotgun.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, Shotgun);

local ShotgunSawnoff = {}
ShotgunSawnoff.Name = "Base.ShotgunSawnoff"
ShotgunSawnoff.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, ShotgunSawnoff);

local Shotgun2 = {}
Shotgun2.Name = "Base.Shotgun2"
Shotgun2.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, Shotgun2);

local Shotgun2Bayonet = {}
Shotgun2Bayonet.Name = "Base.Shotgun2Bayonet"
Shotgun2Bayonet.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, Shotgun2Bayonet);

local ShotgunSemi = {}
ShotgunSemi.Name = "Base.ShotgunSemi"
ShotgunSemi.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, ShotgunSemi);

local ShotgunSemi2 = {}
ShotgunSemi2.Name = "Base.ShotgunSemi2"
ShotgunSemi2.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, ShotgunSemi2);

local DoubleBarrelShotgun = {}
DoubleBarrelShotgun.Name = "Base.DoubleBarrelShotgun"
DoubleBarrelShotgun.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	if open then
		originalSprite = originalSprite .. "_OPEN"
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, DoubleBarrelShotgun);

local DoubleBarrelShotgunSawnoff = {}
DoubleBarrelShotgunSawnoff.Name = "Base.DoubleBarrelShotgunSawnoff"
DoubleBarrelShotgunSawnoff.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	if open then
		originalSprite = originalSprite .. "_OPEN"
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, DoubleBarrelShotgunSawnoff);

local DoubleBarrelShotgunSawnoffNoStock = {}
DoubleBarrelShotgunSawnoffNoStock.Name = "Base.DoubleBarrelShotgunSawnoffNoStock"
DoubleBarrelShotgunSawnoffNoStock.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	if open then
		originalSprite = originalSprite .. "_OPEN"
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, DoubleBarrelShotgunSawnoffNoStock);

local M2400_Shotgun = {}
M2400_Shotgun.Name = "Base.M2400_Shotgun"
M2400_Shotgun.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			if open then
				originalSprite = "M2400FGS_OPEN"
			else
				originalSprite = originalSprite .. "FGS"
			end
		end
	elseif open then
		originalSprite = "M2400_OPEN"
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, M2400_Shotgun);

local M2400_Rifle = {}
M2400_Rifle.Name = "Base.M2400_Rifle"
M2400_Rifle.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			if open then
				originalSprite = "M2400FGS_OPEN"
			else
				originalSprite = originalSprite .. "FGS"
			end
		end
	elseif open then
		originalSprite = "M2400_OPEN"
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, M2400_Rifle);


local LeverRifle = {}
LeverRifle.Name = "Base.LeverRifle"
LeverRifle.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, LeverRifle);

local LeverRifle2 = {}
LeverRifle2.Name = "Base.LeverRifle2"
LeverRifle2.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, LeverRifle2);

local CampCarbine = {}
CampCarbine.Name = "Base.CampCarbine"
CampCarbine.Apply = function(weapon, open)
	local originalSprite = weapon:getOriginalWeaponSprite()
	local stock = weapon:getWeaponPart("Stock")
	if stock ~= nil then
		if stock:getType() == "FiberglassStock" then
			originalSprite = originalSprite .. "FGS"
		end
	end
	weapon:setWeaponSprite(originalSprite)
end
table.insert(VFEWeaponModelTable, CampCarbine);

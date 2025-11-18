require "ISBaseObject"

local SpentCasingPhysics = {}
SpentCasingPhysics.activeCasings = {}
SpentCasingPhysics.GRAVITY = 0.005

function SpentCasingPhysics.addCasing(square, casingType, startX, startY, startZ, velocityX, velocityY, velocityZ)
    if not square then return end

    local casingData = {
        square = square,
        casingType = casingType,
        x = startX,
        y = startY,
        z = startZ,
        velocityX = velocityX or 0,
        velocityY = velocityY or 0,
        velocityZ = velocityZ or 0.1,
        active = true,
        currentWorldItem = nil
    }

    casingData.currentWorldItem = square:AddWorldInventoryItem(casingType, startX, startY, startZ)

    table.insert(SpentCasingPhysics.activeCasings, casingData)
end

function SpentCasingPhysics.update()
    local i = 1

    local XY_STEP = 0.10           -- multiply X/Y velocity by this when adding to position (small step)
    local Z_STEP = 0.05            -- multiply Z velocity by this when adding to position (small step)
    local GRAVITY_SCALE = 1.0      -- scale for the global gravity (keeps existing constant but allows easy tweak)
    local DRAG_XY = 0.97           -- velocity damping for horizontal movement (air resistance)
    local DRAG_Z = 0.995           -- velocity damping for vertical movement
    local SETTLE_THRESHOLD = 0.001 -- when velocities drop below this, consider the casing settled

    while i <= #SpentCasingPhysics.activeCasings do
        local casing = SpentCasingPhysics.activeCasings[i]

        if not casing.square or not casing.active then
            table.remove(SpentCasingPhysics.activeCasings, i)
        else
            casing.velocityZ = casing.velocityZ - (SpentCasingPhysics.GRAVITY * GRAVITY_SCALE)

            casing.x = casing.x + (casing.velocityX * XY_STEP)
            casing.y = casing.y + (casing.velocityY * XY_STEP)
            casing.z = casing.z + (casing.velocityZ * Z_STEP)

            casing.x = PZMath.clamp_01(casing.x)
            casing.y = PZMath.clamp_01(casing.y)
            casing.z = math.max(0, casing.z)

            if casing.currentWorldItem then
                casing.square:removeWorldObject(casing.currentWorldItem:getWorldItem())
                casing.currentWorldItem = nil
            end

            casing.velocityX = casing.velocityX * DRAG_XY
            casing.velocityY = casing.velocityY * DRAG_XY
            casing.velocityZ = casing.velocityZ * DRAG_Z

            if casing.z > 0 then
                casing.currentWorldItem = casing.square:AddWorldInventoryItem(
                    casing.casingType,
                    casing.x,
                    casing.y,
                    casing.z
                )
            else
                casing.square:AddWorldInventoryItem(
                    casing.casingType,
                    casing.x,
                    casing.y,
                    0.0
                )

                if math.abs(casing.velocityX) < SETTLE_THRESHOLD
                    and math.abs(casing.velocityY) < SETTLE_THRESHOLD
                    and math.abs(casing.velocityZ) < SETTLE_THRESHOLD
                then
                    casing.active = false
                    table.remove(SpentCasingPhysics.activeCasings, i)
                    i = i - 1
                else
                    casing.active = false
                    table.remove(SpentCasingPhysics.activeCasings, i)
                    i = i - 1
                end
            end

            i = i + 1
        end
    end
end

local function SpawnCasing(playerObj, weapon)
    if not playerObj or playerObj:isDead() then return end
    if not weapon then return end
    if not weapon:isRanged() then return end

    if weapon:getWeaponReloadType() == "revolver"
        or weapon:getWeaponReloadType() == "doublebarrelshotgun"
        or weapon:getWeaponReloadType() == "doublebarrelshotgunsawn"
        or weapon:getWeaponReloadType() == "breechloader"
    then
        return
    end

    local gunAmmo, replaced = string.gsub(weapon:getAmmoType(), "Base.", "")

    if weapon and weapon:isRanged() and weapon:getCurrentAmmoCount() > 0 and not weapon:isRackAfterShoot() then
        local random_f = newrandom()
        local square = playerObj:getCurrentSquare()
        if not square then return end

        local casingType = "Base." .. gunAmmo .. "_Casing"

        local px, py, pz = playerObj:getX(), playerObj:getY(), playerObj:getZ()

        local angleDeg = playerObj:getDirectionAngle() or 0
        local angle = math.rad(angleDeg)

        local fx = math.cos(angle)
        local fy = math.sin(angle)

        local rx = math.cos(angle + math.pi / 2)
        local ry = math.sin(angle + math.pi / 2)

        local forwardOffset = 0.30
        local sideOffset = 0.25

        local spawnWorldX = px + fx * forwardOffset + rx * sideOffset
        local spawnWorldY = py + fy * forwardOffset + ry * sideOffset
        local spawnWorldZ = 0.6

        local targetTileX = math.floor(spawnWorldX)
        local targetTileY = math.floor(spawnWorldY)
        local targetSquare = getCell():getGridSquare(targetTileX, targetTileY, pz)
        if not targetSquare then
            targetSquare = playerObj:getCurrentSquare()
        end

        local startX = spawnWorldX - targetSquare:getX()
        local startY = spawnWorldY - targetSquare:getY()
        local startZ = spawnWorldZ

        local velX = (random_f:random(10) - 5) / 200
        local velY = (random_f:random(10) - 5) / 200
        local velZ = (random_f:random(10) + 15) / 200

        SpentCasingPhysics.addCasing(targetSquare, casingType, startX, startY, startZ, velX, velY, velZ)
    end
end

local ISRackFirearm_complete_old = ISRackFirearm.complete
function ISRackFirearm:complete()
    ---- Here
    ISRackFirearm_complete_old(self)
end

Events.OnWeaponSwing.Add(SpawnCasing)
Events.OnTick.Add(SpentCasingPhysics.update)

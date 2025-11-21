SpentCasingPhysics = {}

SpentCasingPhysics.WeaponEjectionPortParams = {

    ["Base.AssaultRifle"] = {
        casing = "Base.556Bullets_Casing",
        ammo = "Base.556Bullets",
        forwardOffset = 0.30,
        sideOffset = 0.10,
        heightOffset = 0.45,
        shellForce = 0.15,
        manualEjection = false
    },

    ["Base.CAR15D"] = {
        casing = "Base.556Bullets_Casing",
        ammo = "Base.556Bullets",
        forwardOffset = 0.30,
        sideOffset = 0.10,
        heightOffset = 0.45,
        shellForce = 0.15,
        manualEjection = false
    },

    ["Base.Shotgun"] = {
        casing = "Base.ShotgunShells_Casing",
        ammo = "Base.ShotgunShells",
        forwardOffset = 0.27,
        sideOffset = 0.10,
        heightOffset = 0.45,
        shellForce = 0.15,
        manualEjection = true
    },

}

SpentCasingPhysics.registerWeapon = function(
    weapon,
    casing,
    ammo,
    forwardOffset,
    sideOffset,
    heightOffset,
    shellForce,
    manualEjection)
    SpentCasingPhysics.WeaponEjectionPortParams[weapon] = {
        casing         = casing,
        ammo           = ammo,
        forwardOffset  = forwardOffset or 0,
        sideOffset     = sideOffset or 0,
        heightOffset   = heightOffset or 0,
        shellForce     = shellForce or 0,
        manualEjection = manualEjection or false
    }
end

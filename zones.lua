Zones = {}

Zones["mirror_park"] = PolyZone:Create({
    vector2(1200.0, -800.0),
    vector2(1350.0, -800.0),
    vector2(1350.0, -600.0),
    vector2(1200.0, -600.0)
}, {
    name = "mirror_park",
    minZ = 30.0,
    maxZ = 50.0
})

Zones["sandy_shores"] = PolyZone:Create({
    vector2(1900.0, 3600.0),
    vector2(2000.0, 3600.0),
    vector2(2000.0, 3700.0),
    vector2(1900.0, 3700.0)
}, {
    name = "sandy_shores",
    minZ = 20.0,
    maxZ = 40.0
})
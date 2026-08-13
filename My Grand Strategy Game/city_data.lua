-- TODO?: Eventually add more cities

local city_data = {
    { name = "Madrid",    pctX = 0.45,  pctY = 0.45,  population = 3480000, owner = "none",       controller = "none",       ownerColor = {0.22, 0.22, 0.22} },
    { name = "Lisbon",    pctX = 0.11,  pctY = 0.60,  population = 575740,  owner = "olisbon",    controller = "olisbon",    ownerColor = {0.0, 0.35, 0.33} },
    { name = "Barcelona", pctX = 0.93,  pctY = 0.25,  population = 1690000, owner = "none",       controller = "none",       ownerColor = {0.22, 0.22, 0.22} },
    { name = "Bilbao",    pctX = 0.55,  pctY = 0.10,  population = 347340,  owner = "glopistan",  controller = "glopistan",  ownerColor = {0.1, 0.65, 0.25} },
    { name = "Sevilla",   pctX = 0.31,  pctY = 0.77,  population = 686400,  owner = "algarvorum", controller = "algarvorum", ownerColor = {0.0, 0.55, 1.0} },
    { name = "Porto",     pctX = 0.16,  pctY = 0.25,  population = 231500,  owner = "glopistan",  controller = "none",       ownerColor = {0.1, 0.65, 0.25} },
    { name = "Valencia",  pctX = 0.7,   pctY = 0.53,  population = 800000,  owner = "macklostan", controller = "macklostan", ownerColor = {0.95, 0.85, 0.2} },
    { name = "Gibraltar", pctX = 0.35,  pctY = 0.9,   population = 34000,   owner = "algarvorum", controller = "algarvorum", ownerColor = {0.0, 0.55, 1.0} },
    { name = "Ibiza",     pctX = 0.83,  pctY = 0.59,  population = 159180,  owner = "macklostan", controller = "macklostan", ownerColor = {0.95, 0.85, 0.2} },
    { name = "Zaragoza",  pctX = 0.65,  pctY = 0.25,  population = 693090,  owner = "none",       controller = "none",       ownerColor = {0.22, 0.22, 0.22} },
    { name = "Andorra",   pctX = 0.84,  pctY = 0.17,  population = 24040,   owner = "none",       controller = "none",       ownerColor = {0.22, 0.22, 0.22} },
    { name = "Coruna",    pctX = 0.19,  pctY = 0.08,  population = 251540,  owner = "glopistan",  controller = "glopistan",  ownerColor = {0.1, 0.65, 0.25} },
    { name = "Cartagena", pctX = 0.68,  pctY = 0.745, population = 218210,  owner = "macklostan", controller = "macklostan", ownerColor = {0.95, 0.85, 0.2} },
    { name = "Badajoz",   pctX = 0.25,  pctY = 0.58,  population = 150210,  owner = "olisbon",    controller = "olisbon",    ownerColor = {0.0, 0.35, 0.33} },
    { name = "Salamanca", pctX = 0.32,  pctY = 0.26,  population = 146110,  owner = "montagrand", controller = "montagrand", ownerColor = {0.55, 0.2, 0.6} },
    { name = "Granada",   pctX = 0.55,  pctY = 0.80,  population = 114920,  owner = "macklostan", controller = "macklostan", ownerColor = {0.95, 0.85, 0.20} },
    { name = "Lagos",     pctX = 0.16,  pctY = 0.77,  population = 33490,   owner = "algarvorum", controller = "algarvorum", ownerColor = {0.0, 0.55, 1.00} },
    { name = "Tanger",    pctX = 0.33,  pctY = 0.97,  population = 1280000, owner = "adherbal",   controller = "adherbal",   ownerColor = {0.75, 0.3, 0.15} },
    { name = "Algiers",   pctX = 0.95,  pctY = 0.87,  population = 4330000, owner = "adherbal",   controller = "adherbal",   ownerColor = {0.75, 0.3, 0.15} },
    { name = "Coimbra",   pctX = 0.16,  pctY = 0.45,  population = 140800,  owner = "olisbon",    controller = "olisbon",    ownerColor = {0.0, 0.35, 0.33} },
    { name = "Leon",      pctX = 0.32,  pctY = 0.14,  population = 1580000, owner = "glopistan",  controller = "glopistan",  ownerColor = {0.1, 0.65, 0.25} },
    { name = "City",      pctX = 0.80,  pctY = 0.90,  population = 1000000, owner = "adherbal",   controller = "adherbal",   ownerColor = {0.75, 0.3, 0.15} },
    { name = "City 2",    pctX = 0.65,  pctY = 0.05,  population = 750000,  owner = "none",       controller = "none",       ownerColor = {0.22, 0.22, 0.22} },

    -- Added cities: largest additional mainland Iberian cities by 2025 population.
    -- pctX/pctY are fitted to the existing map's coordinate convention from real city coordinates.
    { name = "Malaga",               pctX = 0.434, pctY = 0.837, population = 599063, owner = "macklostan", controller = "macklostan", ownerColor = {0.95, 0.85, 0.20} },
    { name = "Murcia",               pctX = 0.661, pctY = 0.687, population = 479405, owner = "macklostan", controller = "macklostan", ownerColor = {0.95, 0.85, 0.20} },
    { name = "Valladolid",           pctX = 0.413, pctY = 0.256, population = 302614, owner = "none", controller = "none", ownerColor = {0.22, 0.22, 0.22} },
    { name = "Vigo",                 pctX = 0.17, pctY = 0.186, population = 294489, owner = "glopistan",  controller = "glopistan",  ownerColor = {0.1, 0.65, 0.25} },
    { name = "Hospitalet",           pctX = 0.885, pctY = 0.289, population = 289510, owner = "none", controller = "none", ownerColor = {0.22, 0.22, 0.22} },
    { name = "Gijon",                pctX = 0.36, pctY = 0.05, population = 269894, owner = "glopistan",  controller = "glopistan",  ownerColor = {0.1, 0.65, 0.25} },
    { name = "Vitoria",              pctX = 0.554, pctY = 0.114, population = 260699, owner = "none",       controller = "none",       ownerColor = {0.22, 0.22, 0.22} },
    { name = "Elche",                pctX = 0.690, pctY = 0.654, population = 245557, owner = "macklostan", controller = "macklostan", ownerColor = {0.95, 0.85, 0.20} },
    { name = "Terrassa",             pctX = 0.877, pctY = 0.266, population = 233270, owner = "none", controller = "none", ownerColor = {0.22, 0.22, 0.22} },
    { name = "Badalona",             pctX = 0.893, pctY = 0.282, population = 231542, owner = "none", controller = "none", ownerColor = {0.22, 0.22, 0.22} },
    { name = "Sabadell",             pctX = 0.884, pctY = 0.268, population = 225368, owner = "none", controller = "none", ownerColor = {0.22, 0.22, 0.22} },
    { name = "Oviedo",               pctX = 0.336, pctY = 0.055, population = 223968, owner = "glopistan",  controller = "glopistan",  ownerColor = {0.1, 0.65, 0.25} },
    { name = "Jerez de la Frontera", pctX = 0.317, pctY = 0.839, population = 213634, owner = "algarvorum", controller = "algarvorum", ownerColor = {0.0, 0.55, 1.00} },
    { name = "Loures",               pctX = 0.107, pctY = 0.588, population = 209877, owner = "olisbon",    controller = "olisbon",    ownerColor = {0.0, 0.35, 0.33} },
    { name = "Pamplona",             pctX = 0.625, pctY = 0.119, population = 209094, owner = "none", controller = "none", ownerColor = {0.22, 0.22, 0.22} },
    { name = "Almeria",              pctX = 0.569, pctY = 0.822, population = 205468, owner = "macklostan", controller = "macklostan", ownerColor = {0.95, 0.85, 0.20} },
    { name = "Braga",                pctX = 0.158, pctY = 0.268, population = 203519, owner = "olisbon",    controller = "olisbon",    ownerColor = {0.0, 0.35, 0.33} },
    { name = "Alcala de Henares",    pctX = 0.507, pctY = 0.394, population = 203208, owner = "none", controller = "none", ownerColor = {0.22, 0.22, 0.22} },
    { name = "Leganes",              pctX = 0.479, pctY = 0.412, population = 195734, owner = "none", controller = "none", ownerColor = {0.22, 0.22, 0.22} },
    { name = "Getafe",               pctX = 0.483, pctY = 0.415, population = 193238, owner = "none", controller = "none", ownerColor = {0.22, 0.22, 0.22} }
}

return city_data
-- TODO?: Eventually add more cities
local city_data = {
    {
        name = "Madrid", pctX = 0.45, pctY = 0.45,
        population = 3480000, tier = 6, tax_income = 0,
        owner = "none", controller = "none",
        ownerColor = {0.22, 0.22, 0.22}, selected = false,
        resource_output = {
            manpower = 0, iron = 7, blackpowder = 0, wood = 9, stone = 6, coal = 18, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Lisbon", pctX = 0.11, pctY = 0.60,
        population = 575740, tier = 4, tax_income = 0,
        owner = "olisbon", controller = "olisbon",
        ownerColor = {0.0, 0.35, 0.33}, selected = false,
        resource_output = {
            manpower = 0, iron = 4, blackpowder = 0, wood = 5, stone = 3, coal = 9,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Barcelona", pctX = 0.93, pctY = 0.25,
        population = 1690000, tier = 6, tax_income = 0,
        owner = "lleida", controller = "lleida",
        ownerColor = {0.5, 0, 0}, selected = false,
        resource_output = {
            manpower = 0, iron = 6, blackpowder = 0, wood = 8, stone = 6, coal = 16, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Bilbao", pctX = 0.55, pctY = 0.10,
        population = 347340, tier = 4, tax_income = 0,
        owner = "glopistan", controller = "glopistan",
        ownerColor = {0.1, 0.65, 0.25}, selected = false,
        resource_output = {
            manpower = 0, iron = 5, blackpowder = 0, wood = 4, stone = 3, coal = 11, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Sevilla", pctX = 0.31, pctY = 0.77,
        population = 686400, tier = 5, tax_income = 0,
        owner = "algarvorum", controller = "algarvorum",
        ownerColor = {0.0, 0.55, 1.0}, selected = false,
        resource_output = {
            manpower = 0, iron = 4, blackpowder = 0, wood = 6, stone = 4, coal = 12, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Porto", pctX = 0.16, pctY = 0.25,
        population = 231500, tier = 3, tax_income = 0,
        owner = "glopistan", controller = "none",
        ownerColor = {0.1, 0.65, 0.25}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 4, stone = 2, coal = 6,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Valencia", pctX = 0.7, pctY = 0.53,
        population = 800000, tier = 5, tax_income = 0,
        owner = "macklostan", controller = "macklostan",
        ownerColor = {0.95, 0.85, 0.2}, selected = false,
        resource_output = {
            manpower = 0, iron = 5, blackpowder = 0, wood = 7, stone = 5, coal = 13, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Gibraltar", pctX = 0.35, pctY = 0.9,
        population = 34000, tier = 1, tax_income = 0,
        owner = "algarvorum", controller = "algarvorum",
        ownerColor = {0.0, 0.55, 1.0}, selected = false,
        resource_output = {
            manpower = 0, iron = 3, blackpowder = 0, wood = 5, stone = 6, coal = 2,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Ibiza", pctX = 0.83, pctY = 0.59,
        population = 159180, tier = 2, tax_income = 0,
        owner = "macklostan", controller = "macklostan",
        ownerColor = {0.95, 0.85, 0.2}, selected = false,
        resource_output = {
            manpower = 0, iron = 8, blackpowder = 0, wood = 2, stone = 2, coal = 4,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Zaragoza", pctX = 0.65, pctY = 0.25,
        population = 693090, tier = 5, tax_income = 0,
        owner = "none", controller = "none",
        ownerColor = {0.22, 0.22, 0.22}, selected = false,
        resource_output = {
            manpower = 0, iron = 5, blackpowder = 0, wood = 6, stone = 4, coal = 13, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Andorra", pctX = 0.84, pctY = 0.17,
        population = 24040, tier = 1, tax_income = 0,
        owner = "lleida", controller = "lleida",
        ownerColor = {0.5, 0, 0}, selected = false,
        resource_output = {
            manpower = 0, iron = 5, blackpowder = 0, wood = 8, stone = 9, coal = 2,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Coruna", pctX = 0.19, pctY = 0.08,
        population = 251540, tier = 3, tax_income = 0,
        owner = "glopistan", controller = "glopistan",
        ownerColor = {0.1, 0.65, 0.25}, selected = false,
        resource_output = {
            manpower = 0, iron = 3, blackpowder = 0, wood = 4, stone = 2, coal = 7,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Cartagena", pctX = 0.68, pctY = 0.745,
        population = 218210, tier = 2, tax_income = 0,
        owner = "macklostan", controller = "macklostan",
        ownerColor = {0.95, 0.85, 0.2}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 3, stone = 2, coal = 5,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Badajoz", pctX = 0.25, pctY = 0.58,
        population = 150210, tier = 2, tax_income = 0,
        owner = "olisbon", controller = "olisbon",
        ownerColor = {0.0, 0.35, 0.33}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 3, stone = 2, coal = 4,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Salamanca", pctX = 0.32, pctY = 0.26,
        population = 146110, tier = 2, tax_income = 0,
        owner = "montagrand", controller = "montagrand",
        ownerColor = {0.55, 0.2, 0.6}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 2, stone = 2, coal = 3,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Granada", pctX = 0.55, pctY = 0.80,
        population = 114920, tier = 2, tax_income = 0,
        owner = "macklostan", controller = "macklostan",
        ownerColor = {0.95, 0.85, 0.20}, selected = false,
        resource_output = {
            manpower = 0, iron = 1, blackpowder = 0, wood = 2, stone = 1, coal = 3,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Lagos", pctX = 0.16, pctY = 0.77,
        population = 33490, tier = 1, tax_income = 0,
        owner = "algarvorum", controller = "algarvorum",
        ownerColor = {0.0, 0.55, 1.00}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 6, stone = 5, coal = 2,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Tanger", pctX = 0.33, pctY = 0.97,
        population = 1280000, tier = 5, tax_income = 0,
        owner = "adherbal", controller = "adherbal",
        ownerColor = {0.75, 0.3, 0.15}, selected = false,
        resource_output = {
            manpower = 0, iron = 5, blackpowder = 0, wood = 7, stone = 5, coal = 14, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Algiers", pctX = 0.95, pctY = 0.87,
        population = 4330000, tier = 6, tax_income = 0,
        owner = "adherbal", controller = "adherbal",
        ownerColor = {0.75, 0.3, 0.15}, selected = false,
        resource_output = {
            manpower = 0, iron = 8, blackpowder = 0, wood = 9, stone = 7, coal = 19, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Coimbra", pctX = 0.16, pctY = 0.45,
        population = 140800, tier = 2, tax_income = 0,
        owner = "olisbon", controller = "olisbon",
        ownerColor = {0.0, 0.35, 0.33}, selected = false,
        resource_output = {
            manpower = 0, iron = 1, blackpowder = 0, wood = 2, stone = 1, coal = 3,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Leon", pctX = 0.32, pctY = 0.14,
        population = 1580000, tier = 6, tax_income = 0,
        owner = "glopistan", controller = "glopistan",
        ownerColor = {0.1, 0.65, 0.25}, selected = false,
        resource_output = {
            manpower = 0, iron = 7, blackpowder = 0, wood = 8, stone = 6, coal = 17, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "City", pctX = 0.80, pctY = 0.90,
        population = 1000000, tier = 5, tax_income = 0,
        owner = "adherbal", controller = "adherbal",
        ownerColor = {0.75, 0.3, 0.15}, selected = false,
        resource_output = {
            manpower = 0, iron = 5, blackpowder = 0, wood = 7, stone = 5, coal = 14, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "City 2", pctX = 0.65, pctY = 0.05,
        population = 750000, tier = 5, tax_income = 0,
        owner = "none", controller = "none",
        ownerColor = {0.22, 0.22, 0.22}, selected = false,
        resource_output = {
            manpower = 0, iron = 4, blackpowder = 0, wood = 6, stone = 4, coal = 12, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Malaga", pctX = 0.434, pctY = 0.837,
        population = 599063, tier = 4, tax_income = 0,
        owner = "macklostan", controller = "macklostan",
        ownerColor = {0.95, 0.85, 0.20}, selected = false,
        resource_output = {
            manpower = 0, iron = 4, blackpowder = 0, wood = 5, stone = 4, coal = 10, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Murcia", pctX = 0.661, pctY = 0.687,
        population = 479405, tier = 4, tax_income = 0,
        owner = "macklostan", controller = "macklostan",
        ownerColor = {0.95, 0.85, 0.20}, selected = false,
        resource_output = {
            manpower = 0, iron = 3, blackpowder = 0, wood = 5, stone = 3, coal = 9,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Valladolid", pctX = 0.413, pctY = 0.256,
        population = 302614, tier = 4, tax_income = 0,
        owner = "none", controller = "none",
        ownerColor = {0.22, 0.22, 0.22}, selected = false,
        resource_output = {
            manpower = 0, iron = 3, blackpowder = 0, wood = 4, stone = 3, coal = 8,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Vigo", pctX = 0.17, pctY = 0.186,
        population = 294489, tier = 3, tax_income = 0,
        owner = "glopistan", controller = "glopistan",
        ownerColor = {0.1, 0.65, 0.25}, selected = false,
        resource_output = {
            manpower = 0, iron = 3, blackpowder = 0, wood = 4, stone = 3, coal = 7,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Hospitalet", pctX = 0.885, pctY = 0.289,
        population = 289510, tier = 3, tax_income = 0,
        owner = "lleida", controller = "lleida",
        ownerColor = {0.5, 0, 0}, selected = false,
        resource_output = {
            manpower = 0, iron = 3, blackpowder = 0, wood = 4, stone = 3, coal = 7,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Gijon", pctX = 0.36, pctY = 0.05,
        population = 269894, tier = 3, tax_income = 0,
        owner = "glopistan", controller = "glopistan",
        ownerColor = {0.1, 0.65, 0.25}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 4, stone = 2, coal = 10, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Vitoria", pctX = 0.554, pctY = 0.114,
        population = 260699, tier = 3, tax_income = 0,
        owner = "none", controller = "none",
        ownerColor = {0.22, 0.22, 0.22}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 4, stone = 2, coal = 7,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Elche", pctX = 0.690, pctY = 0.654,
        population = 245557, tier = 3, tax_income = 0,
        owner = "macklostan", controller = "macklostan",
        ownerColor = {0.95, 0.85, 0.20}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 3, stone = 2, coal = 6,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Terrassa", pctX = 0.877, pctY = 0.266,
        population = 233270, tier = 3, tax_income = 0,
        owner = "lleida", controller = "lleida",
        ownerColor = {0.5, 0, 0}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 3, stone = 2, coal = 6,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Badalona", pctX = 0.893, pctY = 0.282,
        population = 231542, tier = 3, tax_income = 0,
        owner = "lleida", controller = "lleida",
        ownerColor = {0.5, 0, 0}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 3, stone = 2, coal = 6,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Sabadell", pctX = 0.884, pctY = 0.268,
        population = 225368, tier = 3, tax_income = 0,
        owner = "lleida", controller = "lleida",
        ownerColor = {0.5, 0, 0}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 3, stone = 2, coal = 6,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Oviedo", pctX = 0.336, pctY = 0.055,
        population = 223968, tier = 3, tax_income = 0,
        owner = "glopistan", controller = "glopistan",
        ownerColor = {0.1, 0.65, 0.25}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 3, stone = 2, coal = 10, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Jerez de la Frontera", pctX = 0.317, pctY = 0.839,
        population = 213634, tier = 2, tax_income = 0,
        owner = "algarvorum", controller = "algarvorum",
        ownerColor = {0.0, 0.55, 1.00}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 3, stone = 2, coal = 5,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Loures", pctX = 0.107, pctY = 0.588,
        population = 209877, tier = 2, tax_income = 0,
        owner = "olisbon", controller = "olisbon",
        ownerColor = {0.0, 0.35, 0.33}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 3, stone = 2, coal = 5,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Pamplona", pctX = 0.625, pctY = 0.119,
        population = 209094, tier = 2, tax_income = 0,
        owner = "none", controller = "none",
        ownerColor = {0.22, 0.22, 0.22}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 3, stone = 2, coal = 5,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Almeria", pctX = 0.569, pctY = 0.822,
        population = 205468, tier = 2, tax_income = 0,
        owner = "macklostan", controller = "macklostan",
        ownerColor = {0.95, 0.85, 0.20}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 3, stone = 2, coal = 4,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Braga", pctX = 0.158, pctY = 0.268,
        population = 203519, tier = 2, tax_income = 0,
        owner = "olisbon", controller = "olisbon",
        ownerColor = {0.0, 0.35, 0.33}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 2, stone = 2, coal = 4,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Alcala de Henares", pctX = 0.507, pctY = 0.394,
        population = 203208, tier = 2, tax_income = 0,
        owner = "none", controller = "none",
        ownerColor = {0.22, 0.22, 0.22}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 2, stone = 2, coal = 4,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Leganes", pctX = 0.479, pctY = 0.412,
        population = 195734, tier = 2, tax_income = 0,
        owner = "none", controller = "none",
        ownerColor = {0.22, 0.22, 0.22}, selected = false,
        resource_output = {
            manpower = 0, iron = 2, blackpowder = 0, wood = 2, stone = 2, coal = 4,  steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    },
    {
        name = "Getafe", pctX = 0.483, pctY = 0.415,
        population = 193238, tier = 2, tax_income = 0,
        owner = "none", controller = "none",
        ownerColor = {0.22, 0.22, 0.22}, selected = false,
        resource_output = {
            manpower = 0, iron = 1, blackpowder = 0, wood = 2, stone = 1, coal = 4, steel = 0, rifles = 0, ammunition = 0
        },
        buildings = {}
    }
}

return city_data
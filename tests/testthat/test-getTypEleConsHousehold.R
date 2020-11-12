test_that("getTypEleConsHousehold", {
  # Tests according to table 2 of the Nipkov study
  # Multi
  expect_equal(getTypEleConsHousehold(occupants = 1,
                                      rooms = 3,
                                      bldgType = "multi",
                                      freezer = "none",
                                      eleCommon = "included"), 2200)
  expect_equal(getTypEleConsHousehold(occupants = 1,
                                      rooms = 3,
                                      bldgType = "multi",
                                      dishwasher = "none",
                                      freezer = "none",
                                      eleCommon = "included"), 1975)
  expect_equal(getTypEleConsHousehold(occupants = 1,
                                      rooms = 3,
                                      bldgType = "multi",
                                      dishwasher = "none",
                                      freezer = "classic",
                                      eleCommon = "included"), 2250)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      rooms = 3.5,
                                      bldgType = "multi",
                                      freezer = "none",
                                      eleCommon = "included"), 2750)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      rooms = 3.5,
                                      bldgType = "multi",
                                      dishwasher = "none",
                                      freezer = "none",
                                      eleCommon = "included"), 2500)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      rooms = 3.5,
                                      bldgType = "multi",
                                      dishwasher = "none",
                                      freezer = "classic",
                                      eleCommon = "included"), 2775)
  expect_equal(getTypEleConsHousehold(occupants = 3,
                                      rooms = 4,
                                      bldgType = "multi",
                                      freezer = "none",
                                      eleCommon = "included"), 3300)
  expect_equal(getTypEleConsHousehold(occupants = 3,
                                      rooms = 4,
                                      bldgType = "multi",
                                      dishwasher = "none",
                                      freezer = "none",
                                      eleCommon = "included"), 3025)
  expect_equal(getTypEleConsHousehold(occupants = 3,
                                      rooms = 4,
                                      bldgType = "multi",
                                      dishwasher = "none",
                                      freezer = "classic",
                                      eleCommon = "included"), 3350)
  expect_equal(getTypEleConsHousehold(occupants = 4,
                                      rooms = 4.5,
                                      bldgType = "multi",
                                      freezer = "none",
                                      eleCommon = "included"), 3850)
  expect_equal(getTypEleConsHousehold(occupants = 4,
                                      rooms = 4.5,
                                      bldgType = "multi",
                                      dishwasher = "none",
                                      freezer = "none",
                                      eleCommon = "included"), 3550)
  expect_equal(getTypEleConsHousehold(occupants = 4,
                                      rooms = 4.5,
                                      bldgType = "multi",
                                      dishwasher = "none",
                                      freezer = "classic",
                                      eleCommon = "included"), 3875)
  expect_equal(getTypEleConsHousehold(occupants = 5,
                                      rooms = 5,
                                      bldgType = "multi",
                                      freezer = "none",
                                      eleCommon = "included"), 4350)
  expect_equal(getTypEleConsHousehold(occupants = 5,
                                      rooms = 5,
                                      bldgType = "multi",
                                      dishwasher = "none",
                                      freezer = "none",
                                      eleCommon = "included"), 4025)
  expect_equal(getTypEleConsHousehold(occupants = 5,
                                      rooms = 5,
                                      bldgType = "multi",
                                      dishwasher = "none",
                                      freezer = "classic",
                                      eleCommon = "included"), 4375)
  expect_equal(getTypEleConsHousehold(occupants = 6,
                                      rooms = 6,
                                      bldgType = "multi",
                                      freezer = "none",
                                      eleCommon = "included"), 4850)
  expect_equal(getTypEleConsHousehold(occupants = 6,
                                      rooms = 6,
                                      bldgType = "multi",
                                      dishwasher = "none",
                                      freezer = "none",
                                      eleCommon = "included"), 4500)
  expect_equal(getTypEleConsHousehold(occupants = 6,
                                      rooms = 6,
                                      bldgType = "multi",
                                      dishwasher = "none",
                                      freezer = "classic",
                                      eleCommon = "included"), 4850)

  # Single
  expect_equal(getTypEleConsHousehold(occupants = 1,
                                      rooms = 4,
                                      bldgType = "single",
                                      freezer = "none",
                                      eleCommon = "included"), 2700)
  expect_equal(getTypEleConsHousehold(occupants = 1,
                                      rooms = 4,
                                      bldgType = "single",
                                      dishwasher = "none",
                                      freezer = "none",
                                      eleCommon = "included"), 2475)
  expect_equal(getTypEleConsHousehold(occupants = 1,
                                      rooms = 4,
                                      bldgType = "single",
                                      dishwasher = "none",
                                      freezer = "classic",
                                      eleCommon = "included"), 2825)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      rooms = 5,
                                      bldgType = "single",
                                      freezer = "none",
                                      eleCommon = "included"), 3550)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      rooms = 5,
                                      bldgType = "single",
                                      dishwasher = "none",
                                      freezer = "none",
                                      eleCommon = "included"), 3300)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      rooms = 5,
                                      bldgType = "single",
                                      dishwasher = "none",
                                      freezer = "classic",
                                      eleCommon = "included"), 3650)
  expect_equal(getTypEleConsHousehold(occupants = 3,
                                      rooms = 5,
                                      bldgType = "single",
                                      freezer = "none",
                                      eleCommon = "included"), 4400)
  expect_equal(getTypEleConsHousehold(occupants = 3,
                                      rooms = 5,
                                      bldgType = "single",
                                      dishwasher = "none",
                                      freezer = "none",
                                      eleCommon = "included"), 4125)
  expect_equal(getTypEleConsHousehold(occupants = 3,
                                      rooms = 5,
                                      bldgType = "single",
                                      dishwasher = "none",
                                      freezer = "classic",
                                      eleCommon = "included"), 4525)
  expect_equal(getTypEleConsHousehold(occupants = 4,
                                      rooms = 6,
                                      bldgType = "single",
                                      freezer = "none",
                                      eleCommon = "included"), 5200)
  expect_equal(getTypEleConsHousehold(occupants = 4,
                                      rooms = 6,
                                      bldgType = "single",
                                      dishwasher = "none",
                                      freezer = "none",
                                      eleCommon = "included"), 4900)
  expect_equal(getTypEleConsHousehold(occupants = 4,
                                      rooms = 6,
                                      bldgType = "single",
                                      dishwasher = "none",
                                      freezer = "classic",
                                      eleCommon = "included"), 5300)
  expect_equal(getTypEleConsHousehold(occupants = 5,
                                      rooms = 6,
                                      bldgType = "single",
                                      freezer = "none",
                                      eleCommon = "included"), 5950)
  expect_equal(getTypEleConsHousehold(occupants = 5,
                                      rooms = 6,
                                      bldgType = "single",
                                      dishwasher = "none",
                                      freezer = "none",
                                      eleCommon = "included"), 5625)
  expect_equal(getTypEleConsHousehold(occupants = 5,
                                      rooms = 6,
                                      bldgType = "single",
                                      dishwasher = "none",
                                      freezer = "classic",
                                      eleCommon = "included"), 6075)
  expect_equal(getTypEleConsHousehold(occupants = 6,
                                      rooms = 7,
                                      bldgType = "single",
                                      freezer = "none",
                                      eleCommon = "included"), 6700)
  expect_equal(getTypEleConsHousehold(occupants = 6,
                                      rooms = 7,
                                      bldgType = "single",
                                      dishwasher = "none",
                                      freezer = "none",
                                      eleCommon = "included"), 6350)
  expect_equal(getTypEleConsHousehold(occupants = 6,
                                      rooms = 7,
                                      bldgType = "single",
                                      dishwasher = "none",
                                      freezer = "classic",
                                      eleCommon = "included"), 6800)

  # Tests according to table 5 of the Nipkov study
  # Multi 1 person
  expect_equal(getTypEleConsHousehold(occupants = 1,
                                      bldgType = "multi",
                                      freezer = "classic",
                                      waterHeater = "none"), 2075)
  expect_equal(getTypEleConsHousehold(occupants = 1,
                                      bldgType = "multi",
                                      freezer = "classic",
                                      waterHeater = "electric"), 3275)
  expect_equal(getTypEleConsHousehold(occupants = 1,
                                      bldgType = "multi",
                                      freezer = "classic",
                                      waterHeater = "heatPump"), 2075)
  # Multi 2 person
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "multi",
                                      freezer = "classic",
                                      waterHeater = "none"), 2625)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "multi",
                                      freezer = "classic",
                                      waterHeater = "electric"), 4625)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "multi",
                                      freezer = "classic",
                                      waterHeater = "heatPump"), 2885)


  # Single 1 person
  expect_equal(getTypEleConsHousehold(occupants = 1,
                                      bldgType = "single",
                                      freezer = "classic",
                                      waterHeater = "none"), 2300)
  expect_equal(getTypEleConsHousehold(occupants = 1,
                                      bldgType = "single",
                                      freezer = "classic",
                                      waterHeater = "electric"), 3700)
  expect_equal(getTypEleConsHousehold(occupants = 1,
                                      bldgType = "single",
                                      freezer = "classic",
                                      waterHeater = "heatPump"), 2750)
  # Single 2 person
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "single",
                                      freezer = "classic",
                                      waterHeater = "none",), 3000)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "single",
                                      freezer = "classic",
                                      waterHeater = "electric"), 5200)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "single",
                                      freezer = "classic",
                                      waterHeater = "heatPump"), 3710)

  # more/less rooms
  # Single
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      rooms = 5,
                                      bldgType = "single"), 2650)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      rooms = 3,
                                      bldgType = "single"), 2472)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      rooms = 7,
                                      bldgType = "single"), 2828)
  # Multi
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      rooms = 5,
                                      bldgType = "multi"), 2488)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      rooms = 2,
                                      bldgType = "multi"), 2212)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      rooms = 5,
                                      bldgType = "multi"), 2488)


  # cooking/baking
  # Multi
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "multi",
                                      cookingBaking = "normal"), 2350)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "multi",
                                      cookingBaking = "occasionally"), 2250)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "multi",
                                      cookingBaking = "intensive"), 2450)
  # Single
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "single",
                                      cookingBaking = "normal"), 2650)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "single",
                                      cookingBaking = "occasionally"), 2550)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "single",
                                      cookingBaking = "intensive"), 2750)
  # Tests according to table 6 of the Nipkov study
  # lighting efficiency
  # Multi 2 person
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "multi",
                                      effLighting = "mix"), 2350)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "multi",
                                      effLighting = "minority"), 2550)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "multi",
                                      effLighting = "majority"), 2150)
  # Multi 3 person
  expect_equal(getTypEleConsHousehold(occupants = 3,
                                      bldgType = "multi",
                                      effLighting = "mix"), 2900)
  expect_equal(getTypEleConsHousehold(occupants = 3,
                                      bldgType = "multi",
                                      effLighting = "minority"), 3155)
  expect_equal(getTypEleConsHousehold(occupants = 3,
                                      bldgType = "multi",
                                      effLighting = "majority"), 2645)
  # Single 2 person
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "single",
                                      effLighting = "mix"), 2650)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "single",
                                      effLighting = "minority"), 2925)
  expect_equal(getTypEleConsHousehold(occupants = 2,
                                      bldgType = "single",
                                      effLighting = "majority"), 2375)
  # Single 3 person
  expect_equal(getTypEleConsHousehold(occupants = 3,
                                      bldgType = "single",
                                      effLighting = "mix"), 3350)
  expect_equal(getTypEleConsHousehold(occupants = 3,
                                      bldgType = "single",
                                      effLighting = "minority"), 3680)
  expect_equal(getTypEleConsHousehold(occupants = 3,
                                      bldgType = "single",
                                      effLighting = "majority"), 3020)

  # dryer
  # Multi
  expect_equal(getTypEleConsHousehold(occupants = 2.0,
                                      bldgType = "multi",
                                      freezer = "none",
                                      dryer = "classic",
                                      eleCommon = "included"), 2750)
  expect_equal(getTypEleConsHousehold(occupants = 2.0,
                                      bldgType = "multi",
                                      freezer = "none",
                                      dryer = "none",
                                      eleCommon = "included"), 2512.5)
  expect_equal(getTypEleConsHousehold(occupants = 2.0,
                                      bldgType = "multi",
                                      freezer = "none",
                                      dryer = "roomAir",
                                      eleCommon = "included"), 2631.25)
  expect_equal(getTypEleConsHousehold(occupants = 2.0,
                                      bldgType = "multi",
                                      freezer = "none",
                                      dryer = "heatPump",
                                      eleCommon = "included"), 2631.25)

  # laundry
  # Multi
  expect_equal(getTypEleConsHousehold(occupants = 2.0,
                                      bldgType = "multi",
                                      freezer = "none",
                                      laundry = "classic",
                                      eleCommon = "included"), 2750)
  expect_equal(getTypEleConsHousehold(occupants = 2.0,
                                      bldgType = "multi",
                                      freezer = "none",
                                      laundry = "hotWaterSupply",
                                      eleCommon = "included"), 2631.25)
  expect_equal(getTypEleConsHousehold(occupants = 2.0,
                                      bldgType = "multi",
                                      freezer = "none",
                                      laundry = "none",
                                      eleCommon = "included"), 2525)

  # dishwasher
  # Multi
  expect_equal(getTypEleConsHousehold(occupants = 2.0,
                                      bldgType = "multi",
                                      freezer = "none",
                                      dishwasher = "classic",
                                      eleCommon = "included"), 2750)
  expect_equal(getTypEleConsHousehold(occupants = 2.0,
                                      bldgType = "multi",
                                      freezer = "none",
                                      dishwasher = "hotWaterSupply",
                                      eleCommon = "included"), 2625) # error in study on page 18, there are 2655
  expect_equal(getTypEleConsHousehold(occupants = 2.0,
                                      bldgType = "multi",
                                      freezer = "none",
                                      dishwasher = "none",
                                      eleCommon = "included"), 2500)

  # Study table 7
  # Multi
  expect_equal(getTypEleConsHousehold(occupants = 1.0,
                                      bldgType = "multi",
                                      eleCommon = "excluded"), 1800)
  expect_equal(getTypEleConsHousehold(occupants = 2.0,
                                      bldgType = "multi",
                                      eleCommon = "excluded"), 2350)
  expect_equal(getTypEleConsHousehold(occupants = 3.0,
                                      bldgType = "multi",
                                      eleCommon = "excluded"), 2900)
  expect_equal(getTypEleConsHousehold(occupants = 4.0,
                                      bldgType = "multi",
                                      eleCommon = "excluded"), 3450)
  expect_equal(getTypEleConsHousehold(occupants = 5.0,
                                      bldgType = "multi",
                                      eleCommon = "excluded"), 3950)
  # Single
  expect_equal(getTypEleConsHousehold(occupants = 1.0,
                                      bldgType = "single",
                                      eleCommon = "included"), 2700)
  expect_equal(getTypEleConsHousehold(occupants = 2.0,
                                      bldgType = "single",
                                      eleCommon = "included"), 3550)
  expect_equal(getTypEleConsHousehold(occupants = 3.0,
                                      bldgType = "single",
                                      eleCommon = "included"), 4400)
  expect_equal(getTypEleConsHousehold(occupants = 4.0,
                                      bldgType = "single",
                                      eleCommon = "included"), 5200)
  expect_equal(getTypEleConsHousehold(occupants = 5.0,
                                      bldgType = "single",
                                      eleCommon = "included"), 5950)


})

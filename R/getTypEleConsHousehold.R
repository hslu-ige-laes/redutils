getTypEleConsHousehold <- function(occupants = 3.0,
                                   rooms = NULL,
                                   bldgType = "single",
                                   dishwasher = "classic",
                                   freezer = "none",
                                   cookingBaking = "normal",
                                   effLighting = "mix",
                                   dryer = "classic",
                                   laundry = "classic",
                                   waterHeater = "none",
                                   eleCommon = "excluded"
                                   ){
  #' Get typical electricity consumption of a household
  #'
  #' Get a typical electricity consumption of a household in kWh/year. This is useful to compare a real dataset with a typical consumption value.
  #' @param occupants numeric number of occupants, minimum 1, maximum 6
  #' @param rooms numeric number of rooms, minimum 1, maximum 9, defaul NULL and internally assumed by the number of occupants
  #' @param bldgType type of building, single family house or multi dwelling untit (\code{"single"} or \code{"multi"}, default \code{"multi"})
  #' @param dishwasher type of dishwasher (\code{"none"}, \code{"classic"} or \code{"hotWaterSupply"}, default \code{"classic"})
  #' @param freezer type of freezer (\code{"none"} or \code{"classic"}, default \code{"none"})
  #' @param cookingBaking cooking and baking behaviour (\code{"occasionally"}, \code{"normal"} or \code{"intensive"}, default \code{"normal"})
  #' @param effLighting energy efficient lighting (\code{"minority"}, \code{"mix"} or \code{"majority"}, default \code{"mix"})
  #' @param dryer type of clothing dryer (\code{"none"}, \code{"roomAir"}, \code{"heatPump"} or \code{"classic"}, default \code{"classic"})
  #' @param laundry type of laundry machine (\code{"none"}, \code{"classic"} or \code{"hotWaterSupply"}, default \code{"classic"})
  #' @param waterHeater type of water heater (\code{"none"}, \code{"electric"} or \code{"heatPump"}, default \code{"none"})
  #' @param eleCommon common electricity (\code{"included"} or \code{"excluded"}, default \code{"excluded"})
  #'
  #' @return Returns a typical electricity consumtion of a comparable Swiss household in kWh/year.
  #'
  #' @details
  #' Source:
  #' Nipkov, J. (2013). \href{https://www.aramis.admin.ch/Default.aspx?DocumentID=61764}{Typischer Haushalt-Stromverbrauch - Schlussbericht}. Bundesamt für Energie (BFE).
  #'
  #' Occupants:
  #' - The persons should be present at least on working days, i.e. at least in the evening and usually for 2 meals.
  #' - Children up to approx. 10 years are to be counted as approx. "½ person".
  #' - Teenagers from about 11 years on are to be counted as adults.
  #'
  #' Rooms:
  #'   - If the effective room number deviates significantly, i.e. by more than 1, from a "typical room number", the typical energy consumption gets adjusted accordingly.
  #'
  #' Dishwasher:
  #' - none: no dishwasher powered with this meter
  #' - classic: dishwasher available, no further classification
  #' - with hot water supply: electrical dishwasher which uses as well hot water to heat up
  #'
  #' Freezer:
  #' - none: no "big" freezer powered with this meter. The one in the refrigerator does not count.
  #' - classic: additional freezer available, no further classification
  #'
  #' Cooking & Baking:
  #' - If cooking and baking is particularly intensive and often, and little hot food is eaten outdoors, this increases the base value by 50 per person.
  #' - Conversely, if the stove and oven are used less intensively and food is eaten outdoors frequently, this reduces the base value by 50 per person.
  #'
  #' Efficient Lighting:
  #' - The mix values apply to a share of efficient lamps of about 40 to 50% (energy saving lamps, LED, fluorescent tubes).
  #' - Attention: Halogen or "Eco-Halogen" lamps are not efficient!
  #' - Majority means more than 80%, minority less than 20%
  #'
  #' Clothes Dryer:
  #' - none: no dryer powered with this meter
  #' - room air dryer: room air dehumidifier in the drying room
  #' - heat pumpt dryer: dryer with integrated heat pump, uses less energy than classic one!
  #' - classic dryer: classical one which is only connected to the electric power
  #'
  #' Washing Machine:
  #' - none: no washing machine powered with this meter
  #' - classic: washing machine available, no further classification
  #' - with hot water supply: electrical washing machine which uses as well hot water to heat up
  #'
  #' Water Heater:
  #' - none: no water heater powered with this meter
  #' - Electric Boiler: separate electric boiler powered with this meter
  #' - Heat Pump: only for single family houses when the water heater is connected to the meter
  #'
  #' Common electricity (building equipment, common lighting):
  #' - included: e.g. for single family houses with main meter
  #' - excluded:  e.g. for multi family houses where the meter of the flat gets analyzed. Normally the common electricity is measured by a separate meter.
  #'
  #' @importFrom checkmate assertNumber assertChoice
  #' @import dplyr
  #' @export
  #' @examples
  #' # single family house
  #' getTypEleConsHousehold(occupants=3, rooms=5.5, bldgType="single", waterHeater="heatPump", eleCommon="included")
  #'
  #' # flat in a multi family house
  #' getTypEleConsHousehold(occupants=3, rooms=4.5, bldgType="multi", freezer="none", eleCommon="excluded")

  # function argument checks
  checkmate::assertNumber(occupants, lower = 1.0, upper = 6.0)
  checkmate::assertNumber(rooms, lower = 1.0, upper = 9.0, null.ok = TRUE)
  checkmate::assertChoice(bldgType, c("single", "multi"))
  checkmate::assertChoice(dishwasher, c("none", "classic", "hotWaterSupply"))
  checkmate::assertChoice(freezer, c("none", "classic"))
  checkmate::assertChoice(cookingBaking, c("occasionally", "normal", "intensive"))
  checkmate::assertChoice(effLighting, c("minority", "mix", "majority"))
  checkmate::assertChoice(dryer, c("none", "roomAir", "heatPump", "classic"))
  checkmate::assertChoice(laundry, c("none", "classic", "hotWaterSupply"))
  checkmate::assertChoice(waterHeater, c("none", "electric", "heatPump"))
  checkmate::assertChoice(eleCommon, c("included", "excluded"))

  bldgTypeInput <- bldgType
  occupantsInput <- min(6.0, max(1.0, as.numeric(occupants)))
  occupantsInput <- round(occupantsInput/0.5)*0.5

  # read table with values
  table <- utils::read.csv2(base::system.file("sampleData/typicalHousholdPowerConsumption.csv", package = "redutils"), stringsAsFactors = FALSE, dec = ".")
  table <- table %>% dplyr::filter(bldgType == bldgTypeInput) %>% dplyr::filter(occupants == occupantsInput)

  # if no rooms is NULL take the default of the table, else round the input
  if(is.null(rooms)){
    rooms <- as.numeric(table %>% dplyr::select(roomDefault))
  }else{
    rooms <- round(rooms/0.5)*0.5
  }

  # get base value
  value <- as.numeric(table %>% dplyr::select(baseVal))

  # corrections of base value
  # room size
  if(as.numeric(rooms) < as.numeric(table$roomCntLoLi)){
    value <- value - table$roomCntCorr
  }
  if(as.numeric(rooms) > as.numeric(table$roomCntHiLi)){
    value <- value + table$roomCntCorr
  }

  # dishwasher
  switch(dishwasher,
         none = {value <- value - table$dishwasherValue},
         classic = {value <- value},
         hotWaterSupply = {value <- value - table$dishwasherHotWaterCorr}
  )

  # freezer
  if(freezer == "classic"){
    value <- value + table$freezerVal
  }

  # cooking & baking
  switch(cookingBaking,
         occasionally = {value <- value - table$cookingCorr},
         normal = {value <- value},
         intensive = {value <- value + table$cookingCorr}
  )

  # efficient lighting
  switch(effLighting,
         minority = {value <- value + table$effLightingCorr},
         mix = {value <- value},
         majority = {value <- value - table$effLightingCorr}
  )

  # dryer
  switch(dryer,
         none = {value <- value - ((table$laundryCorrVal + table$dryerCorrVal) * 0.5)},
         roomAir = {value <- value - ((table$laundryCorrVal + table$dryerCorrVal) * 0.25)},
         heatPump = {value <- value - ((table$laundryCorrVal + table$dryerCorrVal) * 0.25)},
         classic = {value <- value}
  )

  # laundry
  switch(laundry,
         none = {value <- value - (table$laundryCorrVal)},
         classic = {value <- value},
         hotWaterSupply = {value <- value - ((table$laundryCorrVal + table$dryerCorrVal) * 0.25)}
  )

  # water Heater
  switch(waterHeater,
         none = {value <- value},
         electric = {value <- value + table$electricWaterHeater},
         heatPump = {value <- value + table$heatPumpWaterHeater}
  )

  # common electricity
  if(eleCommon == "excluded"){
    value <- value - table$electricityCommonVal
  }

  return(value)
}


mollierHxDiagram <- function(data,
                             graphTempMin = 15.0,
                             graphTempMax = 30.0,
                             graphHumAbsMin = 0.0,
                             graphHumAbsMax = 0.017,
                             altitude = 450,
                             cmfZoneTempMin = 21.0,
                             cmfZoneTempMax = 26.0,
                             cmfZoneHumRelMin = 30.0,
                             cmfZoneHumRelMax = 65.0,
                             cmfZoneHumAbsMin = 0.0,
                             cmfZoneHumAbsMax = 0.012){
  #' D3 Mollier hx Diagram
  #'
  #' Creates D3 Mollier hx Diagram with scatter plot and comfort zone
  #' @param data 	Dataset to use for scatter plot. Must be a data.frame with "datetime, temperature degree celsius, humidity %rH"
  #' @param graphTempMin Graph temperature minimum on y-axis in degree celsius, default 15.0
  #' @param graphTempMax Graph temperature maximum on y-axis in degree celsius, default 30.0
  #' @param graphHumAbsMin Graph humidity minimum on x-axis in kg/kg, default 0.0
  #' @param graphHumAbsMax Graph humidity maximun on x-axis in kg/kg, default 0.017
  #' @param altitude Altitude in meters above sea level to calculate pressure, default 450
  #' @param cmfZoneTempMin Comfort zone temperature minimum in degree celsius, default 21.0
  #' @param cmfZoneTempMax Comfort zone temperature maximum in degree celsius, default 26.0
  #' @param cmfZoneHumRelMin Comfort zone humidity minimum in %rH, default 30.0
  #' @param cmfZoneHumRelMax Comfort zone humidity maximum in %rH, default 65.0
  #' @param cmfZoneHumAbsMin Comfort zone humidity minimum in kg/kg, default 0.0
  #' @param cmfZoneHumAbsMax Comfort zone humidity maximum in kg/kg, default 0.012. Also called sultriness limit (de: Schwülgrenze)
  #'
  #' @return
  #' @export
  #' @examples
  #' library(redutils)
  #' library(r2d3)
  #' library(dplyr)
  #' data <- readRDS(system.file("sampleData/flatTempHum.rds", package = "redutils"))
  #' mollierHxDiagram(data)
  #'
  require(r2d3)
  require(checkmate)

  # function argument checks
  assertNumber(graphTempMin, lower = -40, upper = graphTempMax)
  assertNumber(graphTempMax, lower = graphTempMin, upper = 60)
  assertNumber(graphHumAbsMin, lower = 0, upper = graphHumAbsMax)
  assertNumber(graphHumAbsMax, lower = graphHumAbsMin, upper = 0.1)
  assertNumber(altitude, lower = 0, upper = 8000)
  assertNumber(cmfZoneTempMin, lower = 10, upper = cmfZoneTempMax)
  assertNumber(cmfZoneTempMax, lower = cmfZoneTempMin, upper = 30)
  assertNumber(cmfZoneHumRelMin, lower = 0, upper = cmfZoneHumRelMax)
  assertNumber(cmfZoneHumRelMax, lower = cmfZoneHumRelMin, upper = 100)
  assertNumber(cmfZoneHumAbsMin, lower = 0, upper = cmfZoneHumAbsMax)
  assertNumber(cmfZoneHumAbsMax, lower = cmfZoneHumAbsMin, upper = 0.1)

  # function code
  names(data) <- c("time", "temperature", "humidity")
  data <- data %>% mutate(season = redutils::season(time))

  pressure <- 101325 * (1+(-0.0065*as.numeric(altitude))/288.15)^(-9.80665/(287.058*(-0.0065)))
  r2d3::r2d3(
    data = as_d3_data(data),
    script = system.file("mollierHxDiagram/plot.js", package = "redutils"),
    options = list(
      graphTempMin = graphTempMin,
      graphTempMax = graphTempMax,
      graphHumAbsMin = graphHumAbsMin,
      graphHumAbsMax = graphHumAbsMax,
      graphPressure = pressure,
      cmfZoneTempMin = cmfZoneTempMin,
      cmfZoneTempMax = cmfZoneTempMax,
      cmfZoneHumRelMin = cmfZoneHumRelMin,
      cmfZoneHumRelMax = cmfZoneHumRelMax,
      cmfZoneHumAbsMin = cmfZoneHumAbsMin,
      cmfZoneHumAbsMax = cmfZoneHumAbsMax
    ),
    dependencies = c(
      system.file("mollierHxDiagram/drawComfort.js", package = "redutils"),
      system.file("mollierHxDiagram/coordinateGenerator.js", package = "redutils"),
      system.file("mollierHxDiagram/mollierFunctions.js", package = "redutils")
    )
  )
}

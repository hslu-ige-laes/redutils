getSeason <- function(x, seasonNames = c("Winter","Spring","Summer","Fall")){
  #' Get season from date
  #'
  #' Get the season name out of a date
  #' @param x a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, or fts object..
  #' @param seasonNames concatenated strings with 4 seasons, default c("Winter","Spring","Summer","Fall")
  #'
  #' @return Returns the corresponding season.
  #' @importFrom checkmate assertCharacter
  #' @export
  #' @examples
  #' x <- as.Date("2019-04-01")
  #' getSeason(x) #"Spring"
  #'
  #' x <- as.Date("2019-04-01")
  #' getSeason(x, seasonNames = c("Winter","Frühling","Sommer","Herbst")) #"Frühling"

  require(checkmate)

  # function argument checks
  checkmate::assertCharacter(seasonNames, min.chars = 1, len = 4)

  # function code
  numeric.date <- 100 * lubridate::month(x) + lubridate::day(x)

  cuts <- base::cut(numeric.date, breaks = c(0,0229,0531,0831,1130,1231))

  levels(cuts) <- c(seasonNames[1], seasonNames[2], seasonNames[3], seasonNames[4], seasonNames[1])

  return(as.character(cuts))
}
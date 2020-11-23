getSeason <- function(x, seasonlab = c("Winter","Spring","Summer","Fall")){
  #' Get season from date
  #'
  #' Get the season name out of a date
  #' @param x a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, or fts object..
  #' @param seasonlab Season labels, concatenated strings with 4 seasons, default c("Winter","Spring","Summer","Fall")
  #'
  #' @return Returns the corresponding season.
  #' @importFrom checkmate assertCharacter
  #' @export
  #' @examples
  #' x <- as.Date("2019-04-01")
  #' getSeason(x) #"Spring"
  #'
  #' x <- as.Date("2019-04-01")
  #' getSeason(x, seasonlab = c("Winter","Frühling","Sommer","Herbst")) #"Frühling"

  # function argument checks
  checkmate::assertCharacter(seasonlab, min.chars = 1, len = 4)

  # function code
  numeric.date <- 100 * lubridate::month(x) + lubridate::day(x)

  cuts <- base::cut(numeric.date, breaks = c(0,0229,0531,0831,1130,1231))

  levels(cuts) <- c(seasonlab[1], seasonlab[2], seasonlab[3], seasonlab[4], seasonlab[1])

  return(as.character(cuts))
}

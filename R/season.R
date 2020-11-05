season <- function(x, seasons = c("Winter","Spring","Summer","Fall")){
  #' Get season from date
  #'
  #' Get the season name out of a date
  #' @param x a POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, or fts object..
  #' @param seasons list of seasons, default c("Winter","Spring","Summer","Fall")
  #'
  #' @return Returns the corresponding season.
  #' @export
  #' @examples
  #' x <- as.Date("2019-04-01")
  #' season(x) #"Spring"
  #'
  #' x <- as.Date("2019-04-01")
  #' season(x, c("Winter","Frühling","Sommer","Herbst")) #"Frühling"
  #'
  numeric.date <- 100 * lubridate::month(x) + lubridate::day(x)

  ## input Seasons upper limits in the form MMDD in the "break =" option:
  cuts <- base::cut(numeric.date, breaks = c(0,0229,0531,0831,1130,1231))

  # rename the resulting groups (could've been done within cut(...levels=) if "Winter" wasn't double
  levels(cuts) <- c(seasons[1], seasons[2], seasons[3], seasons[4], seasons[1])

  return(as.character(cuts))
}

# library(xts)
# library(highfrequency)
# library(dplyr)
# library(lubridate)
#
# # Tests
# data <- readRDS(system.file("sampleData/flatTempHum.rds", package = "redutils"))
#
# data <- data %>% select(day, tempMean)
#
# xts <- xts(data[,-1], order.by = data$day)
# tzone(xts) <- locTimeZone
#
#
# func <- "mean"
# agg <- "1d"
# orders <- "YmdHMS"
# locTimeZone <- "UTC"
#
# df <- as.data.frame(aggregateXts(xts, func = "mean", agg = "1d", locTimeZone = "Europe/Zurich"))
#
# aggregateXts <- function(xts, func = "mean", agg = "1d", fill = "", locTimeZone = "Europe/Zurich") {
#   if(length(xts) == 0){
#     return(NULL)
#   }
#
#   na.
#   data <- switch(agg,
#                  "15m" = {
#                    xts.grid <- xts(x = NULL, order.by = seq(from = as.POSIXct(start(xts)), to = as.POSIXct(end(xts)), by = "15 min"))
#                    # Merge regular xts object with original data, filling via zoo::na.approx
#                    temp <- merge(xts, xts.grid)
#
#                    # temp <- aggregateTS(xts, FUN=func, on="minutes", k=15, dropna=FALSE, tz = locTimeZone)
#                    # tzone(temp) <- locTimeZone
#                    return(temp)
#                  },
#                  "1h" = {
#
#                    temp <- period.apply(x = xts, INDEX = endpoints(xts, "hours"), FUN = func)
#                    index(temp) <- as.POSIXct(index(temp), tz = locTimeZone)
#                    return(temp)
#                  },
#                  "1d" = {
#                    # temp <- xts:::.drop.time(apply.daily(xts, func))
#                    temp <- apply.daily(x = xts, FUN = func)
#                    index(temp) <- as.POSIXct(trunc(index(temp), units="days"), tz = locTimeZone)
#                    temp <- temp[!duplicated(index(temp)),]
#                    return(temp)
#                  },
#                  "1W" = {
#                    temp <- apply.weekly(x = xts, FUN = func)
#                    index(temp) <- as.POSIXct(trunc(index(temp), units="days"), tz = locTimeZone)
#                    temp <- temp[!duplicated(index(temp)),]
#                    return(temp)
#                  },
#                  "1M" = {
#                    temp <- apply.monthly(x = xts, FUN = func)
#                    index(temp) <- as.POSIXct(trunc(index(temp), units="days"), tz = locTimeZone)
#                    temp <- temp[!duplicated(index(temp)),]
#                    return(temp)
#                  },
#                  "1Y" = {
#                    temp <- apply.yearly(x = xts, FUN = func)
#                    index(temp) <- as.POSIXct(trunc(index(temp), units="days"), tz = locTimeZone)
#                    temp <- temp[!duplicated(index(temp)),]
#                    return(temp)
#                  }
#   )
#
#   if((agg == "1d" | agg == "1W" | agg == "1M" | agg == "1Y") & (func != "raw")){
#     data$time <- parse_date_time(data$time, "Ymd", tz = locTimeZone)
#   } else {
#     if(grepl("X", rownames(data)[1] , fixed=TRUE)){
#       data$time <- as.POSIXct(data$time, format = "X%Y.%m.%d.%H.%M.%S")
#     } else {
#       data$time <- parse_date_time(data$time, "YmdHMS", tz = locTimeZone)
#     }
#   }
#   return(data)
# }

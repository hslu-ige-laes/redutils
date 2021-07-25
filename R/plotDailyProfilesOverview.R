plotDailyProfilesOverview <- function(data,
                                      locTimeZone = "UTC",
                                      main = "Daily Profiles Overview by Weekday and Season",
                                      ylab = "Energy Consumption (kWh/h)",
                                      col = "black",
                                      confidence = 95.0){
  #' Plot Daily Profiles Overview
  #'
  #' Plot a Graph with Daily Energy Consumption Profiles by Weekday and Season
  #' @param data Dataset to use for plot, minimum 1 hour aggregated. Must be a data.frame with "timestamp YmdHMS, energy consumption"
  #' @param locTimeZone Time zone of timestamp, default "UTC"
  #' @param main Main title of plot, default "Before/After Optimization"
  #' @param ylab y-axis title, default "Energy Consumption (kWh/month)"
  #' @param col Line colour of median value, default "black"
  #' @param confidence Confidence interval for upper ribbon in percent (lower is calculated automatically), default 95 percent"
  #'
  #' @return Returns a ggplot object
  #' @importFrom lubridate parse_date_time floor_date hour wday
  #' @importFrom checkmate assertString assertNumber
  #' @importFrom dplyr group_by mutate ungroup
  #' @importFrom stats quantile
  #' @importFrom ggplot2 ggplot geom_ribbon geom_line labs aes facet_grid theme_minimal theme element_text scale_x_continuous
  #' @export
  #' @examples
  #' data <- readRDS(system.file("sampleData/eboBookEleMeter.rds", package = "redutils"))
  #' plotDailyProfilesOverview(data, locTimeZone = "Europe/Zurich")

  # function argument checks
  checkmate::assertString(locTimeZone)
  checkmate::assertString(main)
  checkmate::assertString(ylab)
  checkmate::assertString(col)
  checkmate::assertNumber(confidence, lower = 50.0, upper = 100.0)


  # function code
  colnames(data) <- c("timestamp", "value")

  data$timestamp <- lubridate::parse_date_time(data$timestamp, "YmdHMS", tz = locTimeZone)

  # agregate hours
  data$hour <- as.POSIXct(lubridate::floor_date(data$timestamp,"hours"), tz = locTimeZone)

  df.h <- data %>%
    dplyr::group_by(hour)%>%
    dplyr::summarise(value=sum(value)) %>%
    dplyr::ungroup()

  if(.Platform$OS.type == "windows"){
    df.h <- df.h %>%
      dplyr::mutate(weekday = lubridate::wday(hour,
                                              label = TRUE,
                                              locale = "English",
                                              abbr = TRUE,
                                              week_start = getOption("lubridate.week.start", 1)),
                    dayhour = lubridate::hour(hour),
                    season = redutils::getSeason(hour)
      )
  } else {
    df.h <- df.h %>%
      dplyr::mutate(weekday = lubridate::wday(hour,
                                              label = TRUE,
                                              locale = "en_US",
                                              abbr = TRUE,
                                              week_start = getOption("lubridate.week.start", 1)),
                    dayhour = lubridate::hour(hour),
                    season = redutils::getSeason(hour)
      )
  }


  # create factors for correct order in plot
  # df.h$weekday <- factor(df.h$weekday, c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday", "Sunday"))
  df.h$season <- factor(df.h$season, c("Spring","Summer","Fall","Winter"))

  df.h <- df.h %>%
    dplyr::group_by(season, weekday, dayhour) %>%
    dplyr::mutate(valueMedian = as.numeric(stats::quantile(value, 0.5, na.rm = TRUE)),
                  valueUpper = as.numeric(stats::quantile(value, confidence/100, na.rm = TRUE)),
                  valueLower = as.numeric(stats::quantile(value, (100-confidence)/100, na.rm = TRUE))) %>%
    dplyr::ungroup()

  plot <- ggplot2::ggplot(df.h) +
    ggplot2::geom_ribbon(ggplot2::aes(x = dayhour, ymin = valueLower, ymax = valueUpper), fill = "darkgrey", alpha = 0.7) +
    ggplot2::geom_line(ggplot2::aes(x = dayhour, y = valueMedian), color = col, alpha = 0.5) +
    ggplot2::labs(x = "\nHour of day", y = paste0(ylab, "\n")) +
    ggplot2::facet_grid(season~weekday) +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(colour = "grey50", size = 8, hjust = 0.5, vjust = 0.5, face = "plain")) +
    ggplot2::theme(axis.text.y.right = ggplot2::element_text(angle = 180)) +
    ggplot2::scale_x_continuous(breaks = seq(from = 0, to = 23, by = 6)) +
    ggplot2::ggtitle(paste0(main, "\n"))

  return(plot)

}

plotHeatmapMedianWeeks <- function(data,
                                   locTimeZone = "UTC",
                                   main = "Heatmap Median per hour by Weekday and Season",
                                   ylab = "Energy Consumption (kWh/h)"){
  #' Plot Heatmap Median Weeks
  #'
  #' Plot Heatmap of Median Energy Consumption by Hour, Weekdays and Seasons of Year
  #' @param data Dataset to use for plot, minimum 1 hour aggregated. Must be a data.frame with "timestamp YmdHMS, energy consumption"
  #' @param locTimeZone Time zone of timestamp, default "UTC"
  #' @param main Main title of plot, default "Heatmap Median per hour by Weekday and Season"
  #' @param ylab y-axis title, default "Energy Consumption (kWh/month)"
  #'
  #' @return Returns a ggplot object
  #' @importFrom lubridate parse_date_time floor_date hour wday
  #' @importFrom checkmate assertString assertNumber
  #' @importFrom dplyr group_by mutate ungroup
  #' @importFrom stats quantile
  #' @importFrom ggplot2 ggplot geom_tile labs aes facet_wrap theme_minimal theme element_text element_blank scale_x_continuous scale_fill_viridis_c
  #' @export
  #' @examples
  #' data <- readRDS(system.file("sampleData/eboBookEleMeter.rds", package = "redutils"))
  #' plotHeatmapMedianWeeks(data, locTimeZone = "Europe/Zurich")

  # function argument checks
  checkmate::assertString(locTimeZone)
  checkmate::assertString(main)
  checkmate::assertString(ylab)

  # function code
  colnames(data) <- c("timestamp", "value")

  data$timestamp <- lubridate::parse_date_time(data$timestamp, "YmdHMS", tz = locTimeZone)

  # agregate hours
  data$hour <- as.POSIXct(lubridate::floor_date(data$timestamp,"hours"), tz = locTimeZone)

  df.h <- data %>%
    dplyr::group_by(hour)%>%
    dplyr::summarise(value = sum(value)) %>%
    dplyr::ungroup()

  df.h <- df.h %>%
    dplyr::mutate(weekday = lubridate::wday(hour,
                                            label = TRUE,
                                            locale = "English",
                                            abbr = TRUE,
                                            week_start = getOption("lubridate.week.start", 1)),
                  dayhour = lubridate::hour(hour),
                  season = redutils::getSeason(hour)
    ) %>%
    select(-hour)

  # calculate mean values per hour
  df.h <- df.h %>%
    dplyr::group_by(season, weekday, dayhour) %>%
    dplyr::mutate(value = stats::median(value)) %>%
    dplyr::ungroup() %>%
    unique()

  # change factors for correct order in plot
  dayorder <- list("Sun","Sat","Fri","Thu","Wed","Tue", "Mon")

  df.h$weekday <- factor(df.h$weekday, levels = dayorder)
  df.h$season <- factor(df.h$season, c("Spring","Summer","Fall","Winter"))

  # crate plot
  plot <- ggplot2::ggplot(df.h,
                          ggplot2::aes(x = dayhour,
                                       y = weekday)) +
    ggplot2::geom_tile(ggplot2::aes(fill = value),
                       colour = "white") +
    ggplot2::facet_wrap(~season, nrow = 1) +
    ggplot2::labs(x = "\nHour of day",
                  y = paste0(ylab, "\n "),
                  fill = "Legend") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(colour = "grey50", size = 8, hjust = 0.5, vjust = 0.5, face = "plain"),
                   panel.grid.major = ggplot2::element_blank(),
                   panel.grid.minor = ggplot2::element_blank()
                   ) +
    ggplot2::scale_x_continuous(breaks = seq(from = 0, to = 24, by = 6)) +
    ggplot2::scale_fill_viridis_c(option = "B") +
    ggplot2::ggtitle(paste0(main, "\n "))

  return(plot)

}


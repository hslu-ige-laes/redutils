plotDailyProfilesDecomposed <- function(data,
                                        locTimeZone = "UTC",
                                        main = "Daily Profiles - Decomposed",
                                        ylab = "delta Energy Consumption",
                                        k = 672,
                                        digits = 1
){
  #' Plot Daily Profiles Decomposed
  #'
  #' Plot a Graph with Decomposed Daily Energy Consumption Profiles by Weekday
  #' @param data Dataset to use for plot, minimum 1 hour aggregated. Must be a data.frame with "timestamp YmdHMS, energy consumption"
  #' @param locTimeZone Time zone of timestamp, default "UTC"
  #' @param main Main title of plot, default "Daily Profiles - Decomposed"
  #' @param ylab y-axis title, default "delta Energy Consumption"
  #' @param k Amount of samples for the rolling window used for the decomosition of the trend component, default 672 which corresponds to 7 days
  #' @param digits Number of digits for mouse-hover text, default 1 digit e.g. 10.3
  #'
  #' @return Returns a ggplot object
  #' @importFrom lubridate wday hour minute parse_date_time
  #' @importFrom checkmate assertString
  #' @importFrom dplyr group_by mutate ungroup select filter
  #' @importFrom ggplot2 ggplot geom_path labs aes theme_minimal theme element_text scale_x_continuous
  #' @importFrom zoo rollmean
  #' @importFrom stats na.omit

  #' @export
  #' @examples
  #' data <- readRDS(system.file("sampleData/eboBookEleMeter.rds", package = "redutils"))
  #' plotDailyProfilesDecomposed(data, locTimeZone = "Europe/Zurich")

  # function argument checks
  checkmate::assertString(locTimeZone)
  checkmate::assertString(main)
  checkmate::assertString(ylab)

  # function code
  colnames(data) <- c("Time", "value")
  data$Time <- lubridate::parse_date_time(data$Time,
                                          orders = "YmdHMS",
                                          tz = locTimeZone)

  # ============== Calculation over whole series =================
  # Analysis based on study "Building electricity consumption: Data analytics of building operations with classical time series decomposition and case based subsetting"
  # Ethan M. et al, 2018
  # https://doi.org/10.1016/j.enbuild.2018.07.056

  # calculate rolling mean and detrend series
  if(.Platform$OS.type == "windows"){
    df.decompose.all <- data %>%
      dplyr::mutate(weekday = lubridate::wday(Time,
                                              label = TRUE,
                                              locale = "English",
                                              abbr = TRUE,
                                              week_start = getOption("lubridate.week.start", 1)),
                    dayhour = lubridate::hour(Time),
                    dayminute = lubridate::minute(Time),
                    trend = zoo::rollmean(value, k, fill = NA),
                    valueDetrended = value - trend) %>%
      stats::na.omit()
  } else {
    df.decompose.all <- data %>%
      dplyr::mutate(weekday = lubridate::wday(Time,
                                              label = TRUE,
                                              locale = "en_US",
                                              abbr = TRUE,
                                              week_start = getOption("lubridate.week.start", 1)),
                    dayhour = lubridate::hour(Time),
                    dayminute = lubridate::minute(Time),
                    trend = zoo::rollmean(value, k, fill = NA),
                    valueDetrended = value - trend) %>%
      stats::na.omit()
  }
  if(.Platform$OS.type == "windows"){
    df.decompose.all <- data %>%
      dplyr::mutate(weekday = lubridate::wday(Time,
                                              label = TRUE,
                                              locale = "English",
                                              abbr = TRUE,
                                              week_start = getOption("lubridate.week.start", 1)),
                    dayhour = lubridate::hour(Time),
                    dayminute = lubridate::minute(Time),
                    trend = zoo::rollmean(value, k, fill = NA),
                    valueDetrended = value - trend) %>%
      stats::na.omit()
  } else {
    df.decompose.all <- data %>%
      dplyr::mutate(weekday = lubridate::wday(Time,
                                              label = TRUE,
                                              locale = "en_US",
                                              abbr = TRUE,
                                              week_start = getOption("lubridate.week.start", 1)),
                    dayhour = lubridate::hour(Time),
                    dayminute = lubridate::minute(Time),
                    trend = zoo::rollmean(value, k, fill = NA),
                    valueDetrended = value - trend) %>%
      stats::na.omit()
  }

  # ============== Subsetting per day =================

  df.decompose.day <- df.decompose.all %>%
    dplyr::select(-Time, -trend, -value)

  # calculate seasonal component
  df.decompose.day <- df.decompose.day %>%
    dplyr::group_by(weekday, dayhour, dayminute) %>%
    dplyr::mutate(seasonal = mean(valueDetrended, na.rm = TRUE)) %>%
    dplyr::select(-valueDetrended) %>%
    unique() %>%
    dplyr::ungroup()

  # set start value of each day to 0
  df.startValues <- df.decompose.day %>%
    dplyr::group_by(weekday) %>%
    dplyr::filter(dayhour == 0, dayminute == 0) %>%
    dplyr::mutate(valueStart = seasonal) %>%
    dplyr::select(-seasonal, -dayhour, -dayminute) %>%
    dplyr::ungroup()

  df.final <- merge(df.decompose.day, df.startValues, by = "weekday") %>% stats::na.omit()

  df.final <- df.final %>%
    dplyr::mutate(value = seasonal - valueStart) %>%
    dplyr::select(-seasonal, -valueStart)

  # prepare data for plot
  df.plot <- df.final %>%
    dplyr::mutate(time = dayhour + dayminute/60,
                  value = round(value, digits)) %>%
    dplyr::arrange(weekday, time)

  plot <- ggplot2::ggplot(df.plot, ggplot2::aes(x = time,
                                                y = value)) +
    ggplot2::geom_path(ggplot2::aes(color = weekday)) +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(colour = "grey50", size = 8, hjust = 0.5, vjust = 0.5, face = "plain")) +
    ggplot2::labs(title = paste0(main, "\n"), x = "\nHour of Day", y = paste0(ylab, "\n"), color = "Legend") +
    ggplot2::scale_x_continuous(breaks = seq(from = 0, to = 24, by = 6)) +
    viridis::scale_color_viridis(discrete = TRUE)

  return(plot)

}

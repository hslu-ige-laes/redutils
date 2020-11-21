plotEnergyConsBeforeAfter <- function(data,
                                      dateOptimization,
                                      locTimeZone = "UTC",
                                      titlePlot = "Before/After Optimization",
                                      titleYAxis = "Energy Consumption \n(kWh/month)"){
  #' Plot Energy Consumption Before/After Optimization
  #'
  #' Plot a Graph with Energy Consumption per Month before/after an Optimization
  #' @param data 	Dataset to use for plot with montly aggregated data. Must be a data.frame with "timestamp, energy consumption"
  #' @param dateOptimization Date of Optimization in format YYYY-MM-DD
  #' @param locTimeZone Time zone of timestamp, default "UTC"
  #' @param titlePlot Main title of plot, default "Before/After Optimization"
  #' @param titleYAxis y-axis title, default "Energy Consumption (kWh/month)"
  #'
  #' @return Returns a ggplot object
  #' @importFrom lubridate parse_date_time year month
  #' @importFrom checkmate assertString
  #' @importFrom dplyr filter group_by mutate ungroup select
  #' @importFrom viridis viridis
  #' @importFrom ggplot2 ggplot geom_line aes geom_ribbon geom_point labs scale_x_discrete scale_color_manual theme_minimal
  #' @export
  #' @examples
  #' data <- readRDS(system.file("sampleData/flatHeatingEnergy.rds", package = "redutils"))
  #' plotEnergyConsBeforeAfter(data, dateOptimization = "2017-09-01")

  # function argument checks
  checkmate::assertString(locTimeZone)
  checkmate::assertString(titlePlot)
  checkmate::assertString(titleYAxis)

  # function code
  colnames(data) <- c("timestamp", "value")

  # add metadata for later filtering
  data$timestamp <- lubridate::parse_date_time(data$timestamp, "YmdHMS", tz = locTimeZone)
  data$year <- lubridate::year(data$timestamp)
  data$month <- lubridate::month(data$timestamp)

  # create two separate data frames for later visualization (before is grey, after is colored)
  dataAfter<- data %>% dplyr::filter(timestamp >= dateOptimization) %>% stats::na.omit()
  dataBefore <- data %>% dplyr::filter(timestamp <= dateOptimization) %>% stats::na.omit()

  # add statistical band values and median of phase "before"
  dataBefore <- dataBefore %>% dplyr::group_by(month) %>% dplyr::mutate(valueMedian = stats::quantile(value, 0.5, na.rm = TRUE),
                                                               valueLower = as.numeric(stats::quantile(value, 0.05, na.rm = TRUE)),
                                                               valueUpper = as.numeric(stats::quantile(value, 0.95, na.rm = TRUE))
  ) %>% dplyr::ungroup()

  # calculate values for different coloring
  yearsAll <- nrow(data %>% dplyr::select(year) %>% unique())
  yearsAfter <- nrow(dataAfter %>% dplyr::select(year) %>% unique())
  yearsBefore <- nrow(dataBefore %>% dplyr::select(year) %>% unique())
  # correction in case the date is during a year
  if((yearsAfter+yearsBefore) > yearsAll){yearsBefore <- yearsBefore - 1}

  # plot graph with all time series
  plot <- ggplot2::ggplot() +
    ggplot2::geom_line(data = dataBefore, ggplot2::aes(x = month, y = value, group = year, color = factor(year)), alpha = 0.5) +
    ggplot2::geom_ribbon(data = dataBefore, ggplot2::aes(x = month, ymin = valueLower, ymax = valueUpper), fill = "orange", alpha = 0.3) +
    ggplot2::geom_line(data = dataBefore, ggplot2::aes(x = month, y = valueMedian), colour = "orange", linetype = "dashed") +
    ggplot2::geom_line(data = dataAfter, ggplot2::aes(x = month, y = value, group = year, colour = factor(year)), alpha = 0.8) +
    ggplot2::geom_point(data = dataAfter, ggplot2::aes(x = month, y = value, group = year, color = factor(year)), alpha = 0.8, shape = 21, fill = "white") +
    ggplot2::labs(title = paste0(titlePlot, "\n"), x = "\nMonth", y = paste0(titleYAxis, "\n"), color = "Years\n") +
    ggplot2::scale_x_discrete(limits = month.abb) +
    ggplot2::scale_color_manual(values=c(rep("grey", yearsBefore), viridis::viridis(yearsAfter)))

  return(plot)

}

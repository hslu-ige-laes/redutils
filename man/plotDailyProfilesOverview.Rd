% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotDailyProfilesOverview.R
\name{plotDailyProfilesOverview}
\alias{plotDailyProfilesOverview}
\title{Plot Daily Profiles Overview}
\usage{
plotDailyProfilesOverview(
  data,
  locTimeZone = "UTC",
  main = "Daily Profiles Overview by Weekday and Season",
  ylab = "Energy Consumption (kWh/h)",
  col = "black",
  confidence = 95
)
}
\arguments{
\item{data}{Dataset to use for plot, minimum 1 hour aggregated. Must be a data.frame with "timestamp YmdHMS, energy consumption"}

\item{locTimeZone}{Time zone of timestamp, default "UTC"}

\item{main}{Main title of plot, default "Before/After Optimization"}

\item{ylab}{y-axis title, default "Energy Consumption (kWh/month)"}

\item{col}{Line colour of median value, default "black"}

\item{confidence}{Confidence interval for upper ribbon in percent (lower is calculated automatically), default 95 percent"}
}
\value{
Returns a ggplot object
}
\description{
Plot a Graph with Daily Energy Consumption Profiles by Weekday and Season
}
\examples{
data <- readRDS(system.file("sampleData/eboBookEleMeter.rds", package = "redutils"))
plotDailyProfilesOverview(data, locTimeZone = "Europe/Zurich")
}

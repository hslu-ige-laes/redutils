
<!-- README.md is generated from README.Rmd. Please edit that file -->

# redutils - R Energy Data Utilities

<!-- badges: start -->

<!-- badges: end -->

The goal of redutils is to provide useful functions and plots to analyze
and visualize energy- and comfort related data.

## Installation

You can install the package from [GitHub](https://github.com/) with:

``` r
#install.packages("devtools")
#library(devtools)

# close first all R Studio Projects
devtools::install_github("hslu-ige-laes/redutils")
```

The package is not (yet) available on CRAN.

## Functions

### getSeason()

Get the season name out of a date for filter and grouping purposes.

``` r
library(redutils)
x <- as.Date("2019-04-01")
getSeason(x)
#> [1] "Spring"
```

Default language is English. You can change that by passing the argument
`seasonNames`:

``` r
library(redutils)
x <- as.Date("2019-04-01")
getSeason(x, seasonNames = c("Winter","Frühling","Sommer","Herbst"))
#> [1] "Frühling"
```

### getTypEleConsHousehold()

Get a typical electricity consumption of a household in kWh/year. This
is useful to compare a real dataset with a typical consumption value.

``` r
# single family house
library(redutils)
getTypEleConsHousehold(occupants=3,
                       rooms=5.5,
                       bldgType="single",
                       waterHeater="heatPump",
                       eleCommon="included")
#> [1] 5370
```

``` r
# flat in a multi family house
library(redutils)
getTypEleConsHousehold(occupants=3,
                       bldgType="multi",
                       freezer="none")
#> [1] 2900
```

Hint: varoius settings can get changed via function arguments.

## Plots

### plotEnergyConsBeforeAfter()

Plot a Graph with Energy Consumption per Month before/after an
Optimization.

``` r
library(redutils)
data <- readRDS(system.file("sampleData/flatHeatingEnergy.rds", package = "redutils"))
plotEnergyConsBeforeAfter(data, dateOptimization = "2017-09-01")
```

<img src="man/figures/README-plotEnergyConsBeforeAfter-1.png" width="100%" />

### plotEnergyConsDailyProfileOverview()

Plot a Graph with Daily Energy Consumption Profiles by Weekday and
Season.

``` r
library(redutils)
data <- readRDS(system.file("sampleData/eboBookEleMeter.rds", package = "redutils"))
plotDailyProfilesOverview(data, locTimeZone = "Europe/Zurich")
```

<img src="man/figures/README-plotDailyProfilesOverview-1.png" width="100%" />

### plotMollierHxDiagram()

Plot a D3 Mollier hx Diagram with scatter plot and comfort zone.

<img src="inst/mollierHxDiagram/example.png" class="illustration" width=600/>

Hint: varoius settings can get changed via function arguments.

<hr>

**Disclaimer**<br> The authors decline any liability or responsibility
in connection with the published documentation

© Lucerne University of Sciences and Arts, 2020

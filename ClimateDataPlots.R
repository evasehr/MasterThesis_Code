######################
# CLIMATE DATA PLOTS #
######################

#plots adjusted after http://mikemeredith.net/blog/2019/plotting_rasters.htm

library(readxl)
library(raster)
library(rgdal)

#import table with GPS coordinates of locations of interest
GPS_coord_7locs <- read_excel("GPS_coord_7locs.xlsx", col_names = FALSE)
View(GPS_coord_7locs)

#get climate data from worldclim database
climate <- getData('worldclim', var='bio', res=2.5)

#define color palette for plots
tempcol <- colorRampPalette(c("purple", "blue", "skyblue", "green", "lightgreen", "yellow", "orange", "red", "darkred"))
tempcol2 <- colorRampPalette(c("#f7fbff","#4292c6","#2171b5","#08519c","#08306b"))

#BIO1 = Annual Mean Temperature
par(mar=c(5,5,3,3), bty="n")
plot(climate$bio1, legend = FALSE, col=tempcol(100), xlim = c(-10, 40), ylim = c(35, 70), legend.mar=20, xlab = "Longitude", ylab="Latitude")
points(GPS_coord_7locs$...2,GPS_coord_7locs$...3, pch=16 )
text(GPS_coord_7locs$...2+1, GPS_coord_7locs$...3+1, GPS_coord_7locs$...4)
title("Annual Mean Temperature", line = 1)
plot(climate$bio1, legend.only=TRUE, col=tempcol(100),
     legend.width=0.7, legend.shrink=0.5,
     legend.args=list(text='Annual Mean Temperature [°C *10]', side=4, font=2, line=3, cex=0.9))

#BIO12 = Annual Precipitation
par(mar=c(5,5,3,3), bty="n")
plot(climate$bio12, legend = FALSE, col = tempcol2(100), xlim = c(-10, 40), ylim = c(35, 70), legend.mar=20, xlab = "Longitude", ylab="Latitude")
points(GPS_coord_7locs$...2,GPS_coord_7locs$...3, pch=16 )
text(GPS_coord_7locs$...2+1, GPS_coord_7locs$...3+1, GPS_coord_7locs$...4)
title("Annual Precipitation", line = 1)
plot(climate$bio12, legend.only=TRUE, col=tempcol2(100),
     legend.width=0.7, legend.shrink=0.5,
     legend.args=list(text='Annual Precipitation [mm]', side=4, font=2, line=3, cex=0.9))


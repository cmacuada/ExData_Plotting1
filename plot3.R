#Project Assignment 1
library(tidyverse)

#Download Data and Data Cleaning
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip")

data <- unzip("data.zip")
data_graph <- read.table(data,header = TRUE,sep = ";")

head(data_graph)
str(data_graph)

data.2 <- as_tibble(data_graph) %>% 
      mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>% 
      filter(Date >= "2007-02-01", Date <="2007-02-02") %>% 
      mutate(across(3:9, function(x) as.numeric(x)),
             datetime = lubridate::ymd_hms(paste(Date, Time)))

#Plot 3
with(data.2, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
with(data.2, lines(datetime, Sub_metering_2, col = "red"))
with(data.2, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", pch = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "blue", "red"), cex = .9)

dev.copy(png, file = "plot3.png", width = 400, height = 400)
dev.off()

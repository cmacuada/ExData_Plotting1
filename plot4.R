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


#Plot 4
par(mfrow = c(2, 2))
with(data.2, plot(x = datetime, y = Global_active_power, xlab = "", ylab = "Global Active Power", type = "l"))
with(data.2, plot(x = datetime, y = Voltage, ylab = "Voltage", type = "l"))

with(data.2, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
with(data.2, lines(datetime, Sub_metering_2, col = "red"))
with(data.2, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright",  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "blue", "red"), cex = 0.5, lty = 1)

with(data.2, plot(datetime, Global_reactive_power, type = "l"))

dev.copy(png, file = "plot4.png", width = 400, height = 400)
dev.off()

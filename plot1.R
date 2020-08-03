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



#Plot 1
hist(data.2$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")


dev.copy(png, file = "plot1.png", width = 400, height = 400)
dev.off()

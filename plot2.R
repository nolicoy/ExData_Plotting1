## Programming Assignment Exploratory Data Analysis - Week 1. Plot 2
## source file
## <a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
## target="_blank" rel="noopener nofollow">Electric power consumption</a>

temp <-tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, temp, mode="wb")

## unzip raw data into working directory:
unzip(temp)

## close connection to the url download:
unlink(temp)

## tbl_df function
library(dplyr)
library(lubridate)
power <- tbl_df(read.table("household_power_consumption.txt", sep=";", header=TRUE, row.names = NULL, stringsAsFactors = FALSE))

# convert ? to NA after testing which is the character that causes NA
# https://stackoverflow.com/questions/17598020/converting-character-to-numeric-without-na-coercion-in-r

# set "?" fields to NAs
power[power=="?"] <- NA

# convert chr format into numeric for columns 3 to 8,  
dat <-power %>% mutate_at(vars(matches("Global|Sub|Voltage")),funs(as.numeric))
dat$DateTime <- strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S")
df <- subset(dat, Date == "1/2/2007" | Date == "2/2/2007")


# use PNG device to create plot, using defaults
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows"))

# create line chart of Global Active Power by Weekday
plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts")


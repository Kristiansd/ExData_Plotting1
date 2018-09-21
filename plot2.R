# 
library(data.table)

if(!file.exists("Electric power consumption")){
  dir.create("Electric power consumption")
}

unzip("household_power_consumption.zip")
file.copy("household_power_consumption.txt","./Electric power consumption/household_power_consumption.txt")
setwd("./Electric power consumption")

ElctricPower <- read.table(file = "household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
Dates1 <- grep("^1/2/2007", ElctricPower$V1) 
Dates2 <- grep("^2/2/2007", ElctricPower$V1)
InfoFebrery <- rbind( ElctricPower[Dates1,], ElctricPower[Dates2,])
names(InfoFebrery) <- c("Date", "Time", "Global_Active_Power", "Global_Reactive_Power", 
                        "Voltage", "Global_Intensity", "Sub_metering_1", "Sub_metering_2", 
                        "Sub_metering_3")


GAP <- as.numeric(InfoFebrery$Global_Active_Power)

len = length(GAP)
pos = c(0, len/2, len)
labeX = c("Thu", "Fri", "Sat")

png("plot2.png", width=480, height=480)

plot(GAP, type="l", ylab = "Global Active Power (kilowatts)", xaxt = "n" , xlab = "")
axis(side = 1, at = pos, label = labeX)
dev.off()

setwd("../")
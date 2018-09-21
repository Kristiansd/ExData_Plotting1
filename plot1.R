################################
#                              #
#   Unzip Files and Read file  #
#                              #
################################

library(data.table)

if(!file.exists("Electric power consumption")){
  dir.create("Electric power consumption")
}

unzip("household_power_consumption.zip")
file.copy("household_power_consumption.txt","./Electric power consumption/household_power_consumption.txt")
setwd("./Electric power consumption")

ElctricPower <- read.table(file = "household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
head(ElctricPower)

#####################################################
#                                                   #
# data from the dates 2007-02-01 and 2007-02-02     #
# preparate data                                    #
#                                                   #
#####################################################

Dates1 <- grep("^1/2/2007", ElctricPower$V1) 
Dates2 <- grep("^2/2/2007", ElctricPower$V1)

InfoFebrery <- rbind( ElctricPower[Dates1,], ElctricPower[Dates2,])

write.table(InfoFebrery, "Consumption on 1st and 2nd Febrery.txt") 

#####################################################
#                                                   #
#####################################################

InfoFebrery <- read.table(file = "Consumption on 1st and 2nd Febrery.txt")
names(InfoFebrery) <- c("Date", "Time", "Global_Active_Power", "Global_Reactive_Power", 
                        "Voltage", "Global_Intensity", "Sub_metering_1", "Sub_metering_2", 
                        "Sub_metering_3")

#

GAP <- as.numeric(InfoFebrery$Global_Active_Power)

png("plot1.png", width=480, height=480)

hist(GAP, breaks = 24, main = "Global Active Power", col = "red", xlim = c(0,6), 
     xlab = "Global Active Power (kilowatts)", xaxt = "n")
axis(side = 1, at = c(0,2,4,6) , tck = -0.01)
dev.off()

setwd("../")
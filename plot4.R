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

# Character to numeric 
GAP <- as.numeric(InfoFebrery$Global_Active_Power)
GRP <- as.numeric(InfoFebrery$Global_Reactive_Power)
VOl <- as.numeric(InfoFebrery$Voltage)
sub1 <- as.numeric(InfoFebrery$Sub_metering_1)
sub2 <- as.numeric(InfoFebrery$Sub_metering_2)
sub3 <- as.numeric(InfoFebrery$Sub_metering_3)

len = length(GAP)
pos = c(0, len/2, len)
labeX = c("Thu", "Fri", "Sat")

# plot4 
png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2))
#plot row = 1, col = 1
plot(GAP, type="l", ylab = "Global Active Power (kilowatts)", xlab = "",  xaxt = "n" )
axis(side = 1, at = pos, label = labeX, tck = -0.01)

#plot row = 1, col = 2 
VOl <- InfoFebrery$Voltage
plot(VOl, type="l", ylab = "Voltage", xlab = "datatime" ,  xaxt = "n")
axis(side = 1, at = pos, label = labeX, tck = -0.01)

#plot row = 2, col = 1
plot(sub1, type = "l" , ylab= "Energy sub metering",  xaxt = "n" , xlab = "")
lines(sub2, col = "red")
lines(sub3, col = "blue")
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), text.font = 1, bty = "n")
axis(side = 1, at = pos, label = labeX, tck = -0.01)

#plot row = 2, col = 2
plot(GRP, type="l", ylab = "Global Reactive Power", xlab = "datatime", xaxt = "n" )
axis(side = 1, at = pos, label = labeX, tck = -0.01)

dev.off()

setwd("../")
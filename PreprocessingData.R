################################
#                              #
#   Unzip Files and Read file  #
#                              #
################################

library(data.table)
library(dplyr)

if(!file.exists("Electric power consumption")){
  dir.create("Electric power consumption")
}

unzip("household_power_consumption.zip")
file.copy("household_power_consumption.txt","./Electric power consumption/household_power_consumption.txt")
setwd("./Electric power consumption")

ElctricPower <- read.table(file = "household_power_consumption.txt", sep = ";")
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

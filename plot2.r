#########################################################################################
# Loads the Individual household electric power consumption data set,
# takes a 2 day subset and creates a plot from the data.
# This is for Assignment 1 of the Exploratory Data Analysis course on Coursera 
# (Johns Hopkins University).
# 
# Author: Joseph Walkenhorst
# Date: 12/04/2015
#########################################################################################

#########################################################################################
# Description of variables in electricity consumption data:
# 1. Date: Date in format dd/mm/yyyy
# 2. Time: time in format hh:mm:ss
# 3. Global_active_power: household global minute-averaged active power (in kilowatt)
# 4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# 5. Voltage: minute-averaged voltage (in volt)
# 6. Global_intensity: household global minute-averaged current intensity (in ampere)
# 7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# 8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# 9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
#########################################################################################

#########################################################################################
# Load the Individual household electric power consumption data set
#########################################################################################
path = "E:\\Users\\Jiz\\Documents\\Study\\Coursera\\Data Science Specialisation\\4. Exploratory Data Analysis\\Week 1\\Assignment 1\\1. Data"
elecData = read.table(paste(path,"household_power_consumption.txt",sep="\\"), sep=";", header=T, colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), na.strings = c("?"))
# put the date and time into a single field and format as POSIXlt
elecData$DateTime = strptime(paste(elecData$Date,elecData$Time,sep=" "), format="%d/%m/%Y %H:%M:%S", tz="GMT")

#########################################################################################
# Subset sample data
#########################################################################################
sampleStartDate = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="GMT")
sampleEndDate = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="GMT")
dataSample = elecData[elecData$DateTime >= sampleStartDate & elecData$DateTime <= sampleEndDate,]
#sort by DateTime
dataSample = dataSample[order(dataSample$DateTime),]

#########################################################################################
# Create plot 2 time series graph and output to PNG file
#########################################################################################
png(paste(path,"plot2.png",sep="\\"), width=480, height=480)
plot(x=dataSample$DateTime, y=dataSample$Global_active_power, type="l", xlab=NA,ylab="Global Active Power (kilowatts)")
dev.off()

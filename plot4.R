setwd("myDirectory") #Sets the working directory

#Reads the file
#Separatory is ";"
#Header is present in the file, therefore, arg header is set to TRUE
#Missing values encoded as "?", therefore "?" read as NA
x <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                stringsAsFactors= FALSE, na.strings = "?")

#Merge dates and times and store as POSIXct object
x$DateTime <- as.POSIXct(paste(x$Date, x$Time), format = " %d/%m/%Y %H:%M:%S")

#Convert dates to the Date class
x$Date <- as.Date(x$Date, "%d/%m/%Y")

#Convert times to the Time class
x$Time <- strptime(x$Time, "%H:%M:%S")

#first day whose data is going to be used as a variable of class Date
day1 = as.Date("2007-02-01")
#second day whose data is going to be used as a variable of class Date
day2 = as.Date("2007-02-02")

#Subset the data from the given days and save it in a new variable y
y <- subset(x, x[,1] == day1 | x[,1] == day2)


#Open a png device setting the height and width to 480 pixels each
png("plot4.png", height = 480, width=480)

#Set global graphical parameters using the par function to set the number 
#of plots and adjust the text size and margins
par(mfrow = c(2,2), mar = c(1,2.5,1,1), mgp= c(1.5,0.5,0), ps = 12)

#Use plot function to create the first line plot with the arguments to reproduce the 
#image on the course website
plot(y$DateTime, y$Global_active_power, type = "l", 
     ylab = "Global Active Power (Kilowatts)", xlab = "")

#Use plot function to create the second line plot with the arguments to reproduce the 
#image on the course website
plot(y$DateTime, y$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#Use plot function to create the third line plot with the arguments to reproduce the 
#image on the course website
plot(y$DateTime, y$Sub_metering_1, type = "l", col = 1, xlab = "", 
     ylab = "Energy sub metering")

#Add the red line corresponding to the variable Sub_metering_2
lines(y$DateTime, y$Sub_metering_2, col = 2)

#Add the blue line corresponding to the variable Sub_metering_3
lines(y$DateTime, y$Sub_metering_3, col = 4)

#Add the legend to the topright corner of the plot
legend("topright", lty = 1, col= c(1, "2", "4"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty = "n", xjust = 1, yjust = 0)

#Use plot function to create the forth line plot with the arguments to reproduce the 
#image on the course website
plot(y$DateTime, y$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")

#Close the graphic device and return the file handle to OS
dev.off()
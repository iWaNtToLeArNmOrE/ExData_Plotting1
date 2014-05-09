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
png("plot2.png", height = 480, width=480)

#Use plot function to create the line plot with the arguments to reproduce the 
#image on the course website
plot(y$DateTime, y$Global_active_power, type = "l", 
     ylab = "Global Active Power (Kilowatts)", xlab = "")

#Close the graphic device and return the file handle to OS
dev.off()
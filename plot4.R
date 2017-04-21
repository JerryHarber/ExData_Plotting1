## downloading data file
Url_data <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
File_data <- "exdata%2Fdata%2Fhousehold_power_consumption"
download.file(Url_data, File_data)
unzip(File_data)

## Read in all data and convert "Date"
df_all <- read.csv("household_power_consumption.txt", sep =";", na.strings = "?", as.is=TRUE)
df_all[,"Date"] <- as.Date(df_all[,"Date"], "%d/%m/%Y")

## Get a subset
df_sub <- subset(df_all, (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Date/Time conversion
df_sub$DateTime <- strptime(paste(df_sub[, "Date"], df_sub[, "Time"]), format = "%Y-%m-%d %H:%M:%S")

par(mfrow = c(2, 2), mar = c(4,4,2,1), oma = c(0,0,2,0))

## Plot - Global_active_power
plot(df_sub$DateTime, df_sub$Global_active_power, type = "l", ylab = "Global Active Power", xlab ="")

## Plot - Voltage
plot(df_sub$DateTime, df_sub$Voltage, type = "l", ylab = "Voltage", xlab ="datetime")

## Plot - Sub_metering
plot(df_sub$DateTime, y = df_sub$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab ="")
points(df_sub$DateTime, y = df_sub$Sub_metering_2, type = "l", col = "red")
points(df_sub$DateTime, y = df_sub$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot - Global_reactive_power
plot(df_sub$DateTime, df_sub$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.copy(png, file = "plot4.png", width = 560, height = 480)
dev.off()
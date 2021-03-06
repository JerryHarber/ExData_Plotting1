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

## Plot histogram to a png device
hist(df_sub$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()


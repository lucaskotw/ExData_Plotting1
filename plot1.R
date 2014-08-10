# Read the first 1000 rows to observe the data
file.name <- "household_power_consumption.txt"
df <- read.table(file.name, header=TRUE, sep=";", nrow=1000)

# By observation, 2007-02-01 and 2007-02-02 should lie in row 66637:69516
# Since the starter date 2006-12-16 starts at 17:24:00. increase a record
# by 1 minute, 2006-12-16 covers 396 rows, regular date covers 1440 rows
rowNames <- c("Date", "Time",
               "Global_active_power", "Global_reactive_power", "Voltage",
               "Global_intensity",
               "Sub_metering_1", "Sub_metering_2","Sub_metering_3")
df <- read.table(file.name, header=TRUE, sep=";", skip=66636, nrows=2880,
                 col.names=rowNames)


# setup output png properties
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")

# create historgram of df
hist(df$Global_active_power,
     col="red",
     main="Globle Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")


# turn off png device
dev.off()

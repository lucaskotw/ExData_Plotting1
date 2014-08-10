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

# Combine date and time to Date/Time
date.time <- paste(df$Date, df$Time)
date.time <- strptime(date.time, "%d/%m/%Y %H:%M:%S")
df$DateTime <- date.time


# setup output png properties
png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

# First graph: global_active_power vs date
with(df, plot(DateTime, Global_active_power, type="l",
     xlab="", ylab="Global Active Power")
)

# Second graph: voltage vs date
with(df, plot(DateTime, Voltage, type="l",
     xlab="datetime", ylab="Voltage")
)

# Third graph: sub metering vs date
with(df, plot(DateTime, Sub_metering_1, type="l", col="black",
              xlab="", ylab="Energy sub metering") )
with(df, points(DateTime, Sub_metering_2, type="l", col="red"))
with(df, points(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", pch = c(NA, NA, NA), lty = c(1, 1, 1), bty="n",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Fourth graph: global_reactive_power vs date
with(df, plot(DateTime, Global_reactive_power, type="l",
              xlab="datetime", ylab="Global_reactive_power")
)


# turn off png device
dev.off()
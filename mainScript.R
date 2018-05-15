#Lists in R

getwd()
machine <- read.csv("Machine-Utilization.csv")
head(machine, 12)
str(machine)
summary(machine)

#Derive Utilization Column
machine$Utilization = 1 - machine$Percent.Idle
head(machine, 10)

#Handling Date-Times in R
?POSIXct
as.POSIXct(machine$Timestamp, format="%d/%m/%Y %H:%M") #for 4 digits year must be with capital "Y"
machine$PosixTime <- as.POSIXct(machine$Timestamp, format="%d/%m/%Y %H:%M")
head(machine, 10)
summary(machine) #POSIXct is recognized by R as "time" not format so we can see mini max median values of it.

#Arranging columns
machine$Timestamp <- NULL #deleted
head(machine, 10)

#changing columns
machine <- machine[,c(4,1,2,3)]
head(machine, 10)
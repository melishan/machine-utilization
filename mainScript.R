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

#Lists
summary(machine)
RL1 <- machine[machine$Machine=="RL1",]
summary(RL1)
#we still see other machines too. We should keep machine as factor
RL1$Machine <- factor(RL1$Machine)
summary(RL1)

#Construct a list
#Character: Machine name
#Vector: (min, mean, max) Utilization for the month (excluding uknown hours)
#Logical: Has utilization ever fallen below 90%? TRUE/FALSE

machine_stats_RL1 <- c(min(RL1$Utilization, na.rm = TRUE),
                        mean(RL1$Utilization, na.rm = TRUE),
                          max(RL1$Utilization, na.rm = TRUE))
machine_stats_RL1

length(which(RL1$Utilization < 0.9)) #Has utilization ever fallen below 90%?
length(which(RL1$Utilization < 0.9)) > 0 #convert it to logical operatior


machine_under_90 <- length(which(RL1$Utilization < 0.9)) > 0
machine_under_90

list_RL1 <- list("RL1", machine_stats_RL1, machine_under_90)
list_RL1 #numbers of components show as double bracket




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
#Vector: All hours where utilization is unknown (NA's)
#dataframe: dataframe: for this machine
#Plot: for all machines

machine_stats_RL1 <- c(min(RL1$Utilization, na.rm = TRUE),
                        mean(RL1$Utilization, na.rm = TRUE),
                          max(RL1$Utilization, na.rm = TRUE))
machine_stats_RL1

length(which(RL1$Utilization < 0.9)) #Has utilization ever fallen below 90%?
length(which(RL1$Utilization < 0.9)) > 0 #convert it to logical operatior


machine_under_90 <- length(which(RL1$Utilization < 0.9)) > 0
machine_under_90

list_RL1 <- list("RL1", machine_stats_RL1, machine_under_90)
list_RL1 #names of components show as double bracket in lists
names(list_RL1) <- c("Machine", "Stats","LowThreshold")
list_RL1
#Another way like with dataframes
list_RL1 <- list(Machine="RL1", Stats=machine_stats_RL1,LowThreshold=machine_under_90)
list_RL1

#Extracting components of a list
#three ways:
#[] - will always return a list
#[[]] - will always return the actual object
#$ - sames as [[]] but prettier 

list_RL1[2]  #it returns elemment of a vector
list_RL1[[2]]  #it returns object not an element of list
list_RL1$Stats #it returns object not an element of list

typeof(list_RL1[2]) #returns list
typeof(list_RL1[[2]]) #returns double 
typeof(list_RL1$Stats) #returns double


#how would you access the 3rd element of the vector (max utilization)
list_RL1
list_RL1[[2]][3] #to pick the spesific element of the vector.
list_RL1$Stats[3] #to pick the spesific element of the vector.

#adding and deleting list components
list_RL1

list_RL1[4] <- "New Information"

#another way to add a component via $
#Vector: All hours where utilization is unknown (NA's)
RL1[is.na(RL1$Utilization), "PosixTime"]
list_RL1$UnknownHours <- RL1[is.na(RL1$Utilization), "PosixTime"]
list_RL1

#remove a component from a list
list_RL1[4] <- NULL
list_RL1

#!!!!Notice: numeraton has shifted
list_RL1[[4]][3]

#add another component
#dataframe: for this machine

list_RL1$data <- RL1
list_RL1

summary(list_RL1)
str(list_RL1)

#subsetting a list
list_RL1$UnknownHours[1]
list_RL1[[4]][1]

list_RL1[1:3]
list_RL1[c(1,4)]
list_RL1[c("Machine", "Stats")]
sublist_RL1 <- list_RL1[c(1,2)]
sublist_RL1
sublist_RL1[[2]][2]

#double square brackets are not for subsetting
#use to access to single component of list 
#list_RL1[[1:3]] #ERROR

list_RL1[1]

#building a timeseries plot
library(ggplot2)

p <- ggplot(data=machine)
p + geom_line(aes(x=PosixTime, y=Utilization, 
                  colour=Machine), size=1.2) +
                  facet_grid(Machine~.) +
                  geom_hline(yintercept = 0.90,
                         colour="Gray", size=1.2,
                         linetype=3) #0.90 is the threshold why we highlight it.
plot2 <- p + geom_line(aes(x=PosixTime, y=Utilization, 
                           colour=Machine), size=1.2) +
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.90,
             colour="Gray", size=1.2,
             linetype=3)

list_RL1$Plot <- plot2
summary(list_RL1)
str(list_RL1)




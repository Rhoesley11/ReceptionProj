# Loading packages 

install.packages('dplyr')
install.packages('tidyverse')
install.packages('magrittr')
library("dplyr")
library("tidyverse")
library("readxl")
library("magrittr")

# Load in Datasets 
RecepHeadcount <- read.csv('C:/Users/12543/Downloads/FI Proj/Reception Headcount - Sheet1.csv')
CallVolumeMay <- read_excel('C:/Users/12543/Downloads/FI Proj/2023-05 Reception Queue Performance Detail.xlsx')
CallVolumeJune <- read_excel('C:/Users/12543/Downloads/FI Proj/2023-06 Reception Queue Performance Detail.xlsx')

# Checking for NaN values 
summary(CallVolumeJune) #Need to remove in Multiple Variables
summary(CallVolumeMay) # Need to remove in Hold
summary(RecepHeadcount)

# Replacing NaN values with zeros
CallVolumeMay[is.na(CallVolumeMay)] <- 0
CallVolumeJune[is.na(CallVolumeJune)] <- 0
RecepHeadcount[is.na(RecepHeadcount)] <- 0
RecepHeadcount ## Forgot there were characters in my column, need to replace


# Checking
summary(CallVolumeMay)
summary(CallVolumeJune)


## Wrangling 

# AVG Calls Answered Daily 
mean(CallVolumeMay$Answer) # 2071.9
mean(CallVolumeJune$Answer) #2160

# AVG of service level % for each month 
mean(CallVolumeJune$`Service Level %`) # 0.87%
mean(CallVolumeMay$`Service Level %`) # 0.93%

# Merge both Call Volumes DF 
CallVolume_Total <- rbind(CallVolumeMay, CallVolumeJune)

# Keepping columns needed for this analysis, removing row 42 for holiday 
CallVolume_Data <- CallVolume_Total[-42, -2:-7] ## Subset into a new DF

## Add RecepHeadcount data to DF through Date
# Changing Date column to fit DF date
names(RecepHeadcount)[names(RecepHeadcount)=="Date"] <- "Interval_Start"
names(CallVolume_Data)[names(CallVolume_Data)=="Interval Start"] <- "Interval_Start"

# Installing package to convert date columns 

install.packages('lubridate')
library("lubridate")

#### Mistake
RecepHeadcount$Interval_Start <- ymd(RecepHeadcount$Interval_Start, quiet = FALSE) ## DONT DO AGAIN

# Re-loading Reception Headcount Data
RecepHeadcount2 <- read.csv('C:/Users/12543/Downloads/FI Proj/Reception Headcount - Sheet1.csv')
names(RecepHeadcount2)[names(RecepHeadcount2)=="Date"] <- "Interval_Start"

# Deleting Sundays = empty rows, and July data for now
HeadCount <- na.omit(RecepHeadcount2) #Did not work
rm(HeadCount) #Removing dataframe created

install.packages('tidyr')
library("tidyr")

print(RecepHeadcount2 %>% drop_na()) #Did not work
na.omit(RecepHeadcount2$Recep.OnQ) #Did not work

rm(Headcount) #Forogt the comma after the parentheses

Headcount2 <- RecepHeadcount2[-c(7,14,21,28,29,35,42,49,50,56,62:91),]

# Need to combine through the Interval Start column, changing format of values?
CallVolume_Data$Interval_Start


Analysis <- merge(CallVolume_Data, Headcount2,by = 'Interval_Start', all=TRUE) # Error message

## Appending Headcount data to CallVolume df ...
# Dropping Interval_Start column
Headcount3 <- Headcount2$Recep.OnQ

# Adding Headcount value as a column to original dataframe
CallVolume_Data$Headcount3 = Headcount3



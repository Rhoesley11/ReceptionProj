## Exploratory Analysis

# Questions being asked of me to answer:
### Does headcount directly impact service level/calls answered?
### Does the headcount Reception have able to support call volume based on trends?
### If headcount increased, would service level/calls answered also increase?

# Graphing service level %  / headcount . Is there a trend?
barplot(CallVolume_Data$`Service Level %`, xlab= CallVolume_Data$Interval_Start, col = "orange")
     points(CallVolume_Data$`Service Level Target %`, CallVolume_Data$`Service Level %`, type = "o", col = "blue")
     lines(CallVolume_Data$Headcount3) # Columns are too tall, blue points stacked all in one column 

     
barplot(CallVolume_Data$`Service Level %`, xlab= CallVolume_Data$Interval_Start, col = "orange")
     points(CallVolume_Data$`Service Level %`, CallVolume_Data$`Service Level Target %`, type = "o", col = 'blue')
     lines(CallVolume_Data$`Headcount3`)

barplot(CallVolume_Data$`Service Level %`, xlab= CallVolume_Data$Headcount3, col = "green")
     points(CallVolume_Data$`Service Level Target %`, CallVolume_Data$ASA, type = "o", col = "orange")
     lines(CallVolume_Data$`Abandon %`)  ### Fix x axis , label?? 
     
library(ggplot2)
     
line_gg <- data.frame(x = c(CallVolume_Data$Interval_Start),
                      y = c(CallVolume_Data$`Service Level %`, CallVolume_Data$`Service Level Target %`),
                      group = c(rep("Service Level %", nrow(CallVolume_Data)),
                                rep("Service Level Target %", nrow(CallVolume_Data))))
head(line_gg)

ggp <- ggplot(line_gg, aes(x, y, col = group)) +
  geom_line()

ggp  # Happy with this - now to add Headcount, then predict volume and headcount for future months 
     # Want to these variables together ..

min(CallVolume_Data$Headcount3) #1 Saturdays = Jess
mean(CallVolume_Data$Headcount3)
summary(Headcount3) #column is a character , change to numeric 

Headcount4 <- as.numeric(CallVolume_Data$Headcount3)

mean(Headcount4) #13.8 = 14 receptionist as our mean for May and June 
mean(Headcount4[1:26]) # May = 14
mean(Headcount4[26:51]) # June = 13.6 ~ 14

# T-test on Service level %
boxplot(CallVolume_Data$`Service Level %`)

t.test(CallVolume_Data$`Service Level %`, mu = 14) #statistically significant 
 

line_Daily <- data.frame(Daily_Calls = c(Headcount4),
                      Service_Level = c(CallVolume_Data$`Service Level %`, CallVolume_Data$`Service Level Target %`),
                      group = c(rep("Abandon %", nrow(CallVolume_Data)),
                                rep("Service Level Target %", nrow(CallVolume_Data))))

head(line_Daily)

ggpD <- ggplot(line_Daily, aes(x, y, col = group)) +
  geom_line()

ggpD

















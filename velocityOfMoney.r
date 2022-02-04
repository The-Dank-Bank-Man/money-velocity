library("readrba")
library("tidyverse")
library("ggthemes") 

m1MoneySupply <- read_rba(series_id = "DMAM1N")
nominalGDP <- read_rba(series_id = "GGDPECCPGDP")
m1MoneySupply <- m1MoneySupply[c(which(m1MoneySupply$date %in% nominalGDP$date)), ]
nominalGDP <- nominalGDP[c(which(nominalGDP$date %in% m1MoneySupply$date)), ]
m1MoneySupply <- m1MoneySupply[ ,c(1,3)]
m1MoneySupply$value <- m1MoneySupply$value * 1000000000
nominalGDP <- nominalGDP[ ,c(1,3)]
nominalGDP$value <- nominalGDP$value * 1000000
date <- nominalGDP$date
velocityOfMoney <- data.frame(date, c(nominalGDP$value / m1MoneySupply$value))
velocityOfMoney <- rename(velocityOfMoney, "value" = "c.nominalGDP.value.m1MoneySupply.value.")
ggplot(data = velocityOfMoney, mapping = aes(x = date, y = value)) + geom_line()
ggplot(data = velocityOfMoney, mapping = aes(x = date, y = value)) + geom_line(size = 1.25) + 
labs(x = "Date of observation", 
y = "Velocity of money", 
title = "Money velocity in Australia", 
chart.subtitle = "with the M1 money supply and nominal GDP", 
chart.caption = "Source: RBA") + theme_economist()
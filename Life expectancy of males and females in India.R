#Data Import

setwd("C:/Users/Akhil PM/OneDrive - Johns Hopkins/Akhil/99. Others/GITHUB")
data <- read.csv("Life expectancy of males and females.csv")

View(data)
colnames(data)

# Libraries

library(ggplot2)
library(gganimate)
library(babynames)
library(hrbrthemes)
library(dplyr)
library(reshape2)
library(reshape) 

data <- data %>% filter(Country=="India")

data_wide <- tidyr::pivot_longer(data = data,names_to = "Gender",values_to ="Life expectancy",col=c("Female.Life.Expectancy","Male.Life.Expectancy"))

data_wide [data_wide=="Female.Life.Expectancy"] <- "Female"
data_wide [data_wide=="Male.Life.Expectancy"] <- "Male"


# Plot
animation_gif <- data_wide %>%
  ggplot( aes(x=Year, y=c(`Life expectancy`),group=Gender,color=Gender)) +
  geom_line() +
  geom_point() +
  scale_color_viridis(discrete = TRUE) +
  ggtitle("Life Expectancy among males and females in India") +
  theme(
    axis.title.x = element_text(hjust = 0.5),  # Horizontal centering for x-axis label
    axis.title.y = element_text(hjust = 0.5)   # Horizontal centering for y-axis label
  ) +
  ylab("Age") +
  xlab("Year") +
  scale_color_manual(values = c("red", "blue")) + 
  transition_reveal(Year)



# Save at gif:
anim_save("Life Expectancy among males and females in India.gif", animation = animation_gif, renderer = gifski_renderer())

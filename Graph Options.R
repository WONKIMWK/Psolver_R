# ------------------------------------------------------------

# Graph Options

# ---------------------------------------------------------
# Contact Information--------------------------------

# Modified    : 
# Created     : Mar. 20 2024
# Author      : Wonjong Kim
# Affiliation : University of Alabama
# E-mail      : wkim22@crimson.ua.edu
# ----------------------------------------------------------------


# load packages ----------------------------------------------------

if(!require("tidyverse")) install.packages("tidyverse")
if(!require("kableExtra")) install.packages("kableExtra")
if(!require("stargazer")) install.packages("stargazer")

library(tidyverse) # Including all basic packages, such as dplyr
library(kableExtra) # To make a LaTex table
library(stargazer) # To make a LaTex table easier

# Drawing Scatterplot ----------------------------------------------

## Check Dataset -----------------------------------------------------
### 'mpg' data (fuel economy data subset) are included in 'ggplot2'
mpg <- mpg
str(mpg)
summary(mpg)

## Graph w/ ggplot ----------------------------------------------------

Grp <- ggplot(data = mpg) +
  geom_point(aes(y = cty, x = hwy, color = drv, shape = drv))
print(Grp)

## Add a fitted line ---------------------------------------
Grp.fit <- Grp +
  geom_smooth(aes (y = cty, x = hwy), # Designate y and x 
              method = "lm", # estimation
              se = FALSE, # If you want to show the standard error
              colour = "red", # Color
              linetype = "dashed", # line shape
              linewidth = 1.2 #
              )
Grp.fit

## Add aesthetics ----------------------------------------------------

### Add labels
Grp.add <- Grp +
  labs(title = "Correlation between mileage in Cityway and Highway", #Title
       y = "Cityway", #Y axis
       x = "Highway", #X axis
       color = "Drive Type", shape = "Drive Type" #legend title
  ) +
  scale_color_discrete(labels = c("4", "Front", "Rear")) + # legend label (color)
  scale_shape_discrete(labels = c("4", "Front", "Rear")) # legend label (shape)

print(Grp.add)

## Draw separate panel by categories -----------------------------------

Grp.group <- Grp +
  facet_wrap(~ drv, # Target category you want to divide
             ncol = 3, # Number of columns of panel
             labeller = labeller(drv = c("4"="4WD","f"="Front","r" = "Rear"))
             )
Grp.group


# Line graph -------------------------------------------------------------
AP <- AirPassengers

str(AP)
summary(AP)

Monthly.date <- seq(from = as.Date("1949-01-01"), 
                    to =  as.Date("1960-12-01"), by = "month")
## make it as data.frame
AP.dat <- data.frame(t = Monthly.date, AP = AP)

head(AP.dat)
str(AP.dat)
summary(AP.dat)


line.AP <- ggplot(data = AP.dat)+
  geom_line(aes(y = AP, x = t))

line.AP

## Adding time trend
line.AP.trend <- line.AP +
  geom_smooth(method = "lm", aes(y = AP, x = t))

line.AP.trend


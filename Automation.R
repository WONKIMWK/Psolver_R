# ------------------------------------------------------------

# Table and Graph automation

# ---------------------------------------------------------
# Contact Information--------------------------------

# Modified    : Mar 20, 2023
# Created     : Oct 08, 2023
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

# Check Dataset -----------------------------------------------------
## 'mpg' data (fuel economy data subset) are included in 'ggplot2'
mpg <- mpg
str(mpg)
summary(mpg)

# Graph w/ ggplot ----------------------------------------------------

Grp <- ggplot(data = mpg) +
  geom_point(aes(y = cty, x = hwy, color = drv, shape = drv))
print(Grp)

# Add aesthetics on Graph -------------------------------------------

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

### If you need a greyscale graph
Grp.bw <- Grp.add +
  theme_bw() + #Black and white background
  scale_color_grey(labels = c("4", "Front", "Rear")) # Greyscale

print(Grp.bw)

## Save the result 
### use ggsave() after print the result

## Save in png
ggsave(Grp.add, filename = "CorrML.png",
       width = 8, height = 8)

## Save in pdf
ggsave(Grp.add, filename = "CorrML.pdf",
       width = 8, height = 8)

# Table --------------------------------------------------------------
## Test. Average city mileage by manufacturer Drive type
Av.ML <- mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(Av_cty = mean(cty))
print(Av.ML)

## Export in Latex format
Av.ML %>% 
  kbl(caption = "Average City Mileage by Manufacturer, Drive Type",
      format = "latex")

# Table using stargazer
## Summary statistics

## Works with dataframe
MPG <- as.data.frame(mpg)
stargazer(MPG,
          type = "text")

## Regression result
Reg <- lm(cty ~ cyl + drv,
          data = mpg)
stargazer(Reg, 
          type = "text")

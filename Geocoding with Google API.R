# Type this in the Console. Your API key is encrypted and saved in your doc folder.

# register_google(key = "[your Google API key]", write = TRUE)

# How to get lat-long data

library(ggmap)

addr <- data.frame(Address = "Location_Address")

addr.geo <- mutate_geocode(addr, location = Address, output = "latlona")
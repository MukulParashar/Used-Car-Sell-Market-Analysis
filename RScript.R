
install.packages("tidyverse")
library(tidyverse)

usedcars <- read_csv("usedcar.csv")

summary(usedcars)
colSums(is.na(usedcars))


usedcars <- usedcars %>% mutate(Manufacturer = substr(Name,1,regexpr(" ",Name)-1))
usedcars$Manufacturer <- str_replace(df$Manufacturer,"Land","Land-Rover")
usedcars$Mileage <- as.numeric(substr(usedcars$Mileage,1,regexpr(" ",usedcars$Mileage)-1))

na.omit(usedcars)

df <- usedcars


sell <- df %>% group_by(City = Location) %>% summarise(No_of_Cars_on_Sell = n())

ggplot(data = sell) +
  geom_bar(mapping = aes(x = reorder(City, -No_of_Cars_on_Sell), y = No_of_Cars_on_Sell), fill = "yellowgreen", colour = "black", stat = "identity") +
  geom_text(aes(x = City, y = No_of_Cars_on_Sell, label = No_of_Cars_on_Sell), vjust=1.6, size=3.5) +
  scale_y_continuous("No. of Cars on Sell") +
  scale_x_discrete("City") +
  theme(axis.text.x = element_text(angle = 30, vjust = 1)) +
  scale_fill_brewer(palette="Paired")




carloc <- select(df, c(Location, Owner_Type))
carloc <- carloc %>% group_by(Location, Owner_Type) %>% summarise(No_of_Cars = n())

ggplot(carloc[order(carloc$Owner_Type, decreasing = T),]) +
  geom_bar(mapping = aes(x = Location, y = No_of_Cars, fill = factor(Owner_Type, levels=c("Fourth & Above","Third","Second","First" ))), 
           position = "fill",
           stat = "identity") + 
  scale_y_continuous("Percentage of Cars", labels = scales::percent) +
  scale_x_discrete("City") +
  scale_fill_brewer(palette="Greens") +
  theme_linedraw() +
  labs(fill = "Owner_Type") +
  theme(axis.text.x = element_text(angle = 30, vjust = 0.5))

  
  
  

a <- df %>% group_by(Car_Brand = Manufacturer) %>% summarise(No_of_Cars_on_Sell = n())
top_10 <- a %>% arrange(-No_of_Cars_on_Sell) %>% top_n(10)

ggplot(data = top_10) +
  geom_bar(mapping = aes(x = reorder(Car_Brand, No_of_Cars_on_Sell), y = No_of_Cars_on_Sell, fill = Car_Brand ),color = "black", stat = "identity") +
  geom_text(aes(x = Car_Brand, y = No_of_Cars_on_Sell, label = No_of_Cars_on_Sell), hjust=1.6, size=3.5) +
  scale_y_continuous("No. of Cars on Sell") +
  scale_x_discrete("Car Brands") +
  coord_flip()
  
  

df2 <- select(df,Fuel_Type,Kilometers_Driven, Manufacturer, Owner_Type, Mileage, Engine)

a <- df2 %>% group_by(Manufacturer, Fuel_Type) %>% summarise(No_of_Cars_on_Sell = n())
a <- a %>% filter(Manufacturer %in% c("Maruti","Hyundai","Honda","Toyota","Mercedes-Benz","Volkswagen","Ford","Mahindra","BMW","Audi"))

  
  
ggplot(data = df2) +
  geom_bar(mapping = aes(x = Fuel_Type, fill = Owner_Type), position = "dodge")

ggplot(data = a) +
  geom_bar(mapping = aes(x = Manufacturer, y = No_of_Cars_on_Sell, fill = Fuel_Type),
           stat = "identity") +
  scale_fill_brewer(palette="Blues") +
  theme(axis.text.x = element_text(angle = 30, vjust = 1))

ggplot(data = df)+
  geom_histogram(mapping = aes(x = Fuel_Type, y = Mileage, fill = Owner_Type), stat = "identity", position = "dodge")

ggplot(data = df) +
  geom_histogram(mapping = aes(x = Year, fill =  Transmission), position = "dodge", bins = 100) +
  scale_y_continuous("No of Cars on Sell") +
  scale_x_continuous("Year of Manufacture")

ggplot(data = df) +
  geom_bar(mapping = aes(x = Year, y = Mileage,  fill = Transmission), stat = "identity", position = "dodge", bins = 50) +
  scale_y_continuous("Mileage") +
  scale_x_continuous("Year of Manufacture")

ggplot(data = df) +
  geom_bar(mapping = aes(x = Year, y = Mileage,  fill = Fuel_Type), stat = "identity", position = "dodge", bins = 50) +
  scale_y_continuous("Mileage") +
  scale_x_continuous("Year of Manufacture")
 

```{r}

install.packages("tidyverse")
library(tidyverse)

usedcars <- read_csv(usedcars.csv)

summary(usedcars)
colSums(is.na(usedcars))

na.omit(usedcars)

df <- usedcars %>% mutate(Manufacturer = substr(Name,1,regexpr(" ",Name)-1))
df$Manufacturer <- str_replace(df$Manufacturer,"Land","Land-Rover")

sell <- df %>% group_by(City = Location) %>% summarise(No_of_Cars_on_Sell = n())

ggplot(data = sell) +
  geom_bar(mapping = aes(x = reorder(City, -No_of_Cars_on_Sell), y = No_of_Cars_on_Sell), fill = "yellowgreen", colour = "black", stat = "identity") +
  geom_text(aes(x = City, y = No_of_Cars_on_Sell, label = No_of_Cars_on_Sell), vjust=1.6, size=3.5) +
  scale_y_continuous("No. of Cars on Sell") +
  scale_x_discrete("City") +
  theme(axis.text.x = element_text(angle = 30, vjust = 1)) +
  scale_fill_brewer(palette="Paired")
  
  
  
  

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

b <- df2 %>% group_by(Manufacturer, Owner_Type) %>% summarise(No_of_Cars_on_Sell = n())
b <- b %>% filter(Manufacturer %in% c("Maruti","Hyundai","Honda","Toyota","Mercedes-Benz","Volkswagen","Ford","Mahindra","BMW","Audi"))


  
  
ggplot(data = df2) +
  geom_bar(mapping = aes(x = Fuel_Type, fill = Owner_Type), position = "dodge")

ggplot(data = a) +
  geom_bar(mapping = aes(x = Manufacturer, y = No_of_Cars_on_Sell, fill = Fuel_Type),
           stat = "identity") +
  scale_fill_brewer(palette="Blues") +
  theme(axis.text.x = element_text(angle = 30, vjust = 1))

ggplot(data = df) +
  geom_histogram(mapping = aes(x = Year, fill =  Transmission), position = "dodge", bins = 100) +
  scale_y_continuous("No of Cars on Sell") +
  scale_x_continuous("Year of Manufacture")
  ```


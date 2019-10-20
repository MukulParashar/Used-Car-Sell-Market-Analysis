## EDA on used cars data on sell in India
This repository is an exhaustive analytical report on Used Cars Selling Industry in the Tier-1 Cities of 
India and for that, the supporting data is taken from the `Kaggle`.

With the help of the analysis, I've tried to answer the following questions:

**1. Which city people majorly put their car on sell.**<br/>
**2. Which car brands are majorly on sale.**<br/>
**3. Which fuel type and which hand cars are on sell in top 10 brands.**<br/>
**4. Distribution of Kms travelled by car by fuel type, owner type and Top 10 manufacturer.**<br/>

The supporting data for the analysis is described below:

| Column Name       | Description                                              |
|-------------------|----------------------------------------------------------|
| Name              | Name of the Car on Sell                                  |
| Location          | City of the Car on Sell                                  |
| Years             | Year of manufacture                                      |   
| Kilometers_Driven | Kms Car travelled                                        |
| Fuel_Type         | Petrol, Diesel, CNG, LPG, Electric                       | 
| Transmission      | Manual, Automatic                                        |
| Owner_Type        | First, Second, Third, Fourth Hand & Above                |
| Mileage           | Mileage of the Car                                       |
| Engine            | Engine Displacement                                      |                                      
| Power             | Power of Engine                                          |
| Seats             | No. of Seats in Car                                      |

## Data Manupulation

First we will install the `tidyverse` library and load it on RStudio followed by importing data set as dataframe named `usedcars`.

```{r}
install.packages("tidyverse")
library(tidyverse)

usedcars <- read_csv("usedcars.csv")
```

Now we will check if there are any missing data using

```{r}
summary(usedcar)
```

When we will run the above code we will see the following result in console:

```
     Name             Location              Year      Kilometers_Driven  Fuel_Type         Transmission      
 Length:7253        Length:7253        Min.   :1996   Min.   :    171   Length:7253        Length:7253       
 Class :character   Class :character   1st Qu.:2011   1st Qu.:  34000   Class :character   Class :character  
 Mode  :character   Mode  :character   Median :2014   Median :  53416   Mode  :character   Mode  :character  
                                       Mean   :2013   Mean   :  58699                                        
                                       3rd Qu.:2016   3rd Qu.:  73000                                        
                                       Max.   :2019   Max.   :6500000                                        
                                                                                                             
  Owner_Type          Mileage             Engine             Power               Seats         
 Length:7253        Length:7253        Length:7253        Length:7253        Min.   : 0.00
 Class :character   Class :character   Class :character   Class :character   1st Qu.: 5.00
 Mode  :character   Mode  :character   Mode  :character   Mode  :character   Median : 5.00 
                                                                             Mean   : 5.28                     
                                                                             3rd Qu.: 5.00                     
                                                                             Max.   :10.00                     
                                                                             NA's   :53 
 ```
 
The above result show that the missing values are only available in `Seats` Variable. But, here's the catch. The `summary()`
function do not show all the missing values. Therefore, will be use the `colSums()` function.

```{r}
colSums(usedcars)
```

And the above will give the following result in the console:

```
Name          Location              Year Kilometers_Driven         Fuel_Type      Transmission 
                0                 0                 0                 0                 0                 0 
       Owner_Type           Mileage            Engine             Power             Seats
                0                 2                46                46                53
                
```

Now it is clear that there are many more other type of missing values than NA. Hence they need to be removed using ` na.omit(usedcars)` function which will remove all the rows having even a single missing values.

Now as I see that the Car Name is a combination of car brand and model. So, to get just the car manufacturer name the code written below will be helpful as getting only manufacturer name will simply our analysis

```{r}
usedcars <- usedcars %>% mutate(Manufacturer = substr(Name,1,regexpr(" ",Name)-1))
```
The above code will add a new column with name Manufacturer having car brand name in it. I observe that in the new column `Manufacturer` the car manufactured by Land Rover is returned as Land only. To correct `str_replace()` function will be used.

```{r}
usedcars$Manufacturer <- str_replace(df$Manufacturer,"Land","Land-Rover")
```
Now all the data in the `Manufacturer` column is erroe free.

## Data Visualisation

As we start analysing and plotting the data we observe that:

* **No. of cars on sell in different cities of India with Mumbai having maximum number of cars to sell.**

![alt text](https://github.com/MukulParashar/Used_Car_Sell_India/blob/master/images/City%20and%20Cars%20Count.png)

**The possible explanation for the above observation can be that as Mumbai being city with heavy traffic more and more people are selling the car they owned and starting to use public commute for travelling.**

* **The top 10 most selling used cars brands are shown in the plot below where the most selling Maruti Cars among all owner type.**
![alt text](https://github.com/MukulParashar/Used_Car_Sell_India/blob/master/images/top%2010%20brands.png)

**The reason for the above plot can be because of Maruti's less efficient cars as compared to other brands. Other reasons could be unavailability of parts, improper service and many more.**













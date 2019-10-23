## EDA on used cars data on sell in India
This repository is an exhaustive analytical report on Used Cars Selling Industry in the Tier-1 Cities of 
India and for that, the supporting data is taken from the `Kaggle`.

The supporting data for the analysis is described below:

| Column Name       | Description                                              |
|-------------------|----------------------------------------------------------|
| Name              | Name of the Car on Sell                                  |
| Location          | City of the Car on Sell                                  |
| Years             | Year of manufacture                                      |   
| Kilometers_Driven | Kms Car travelled                                        |
| Fuel_Type         | Petrol, Diesel, CNG, LPG, Electric                       | 
| Transmission      | Manual, Automatic                                        |
| Owner_Type        | First, Second, Third, Fourth & Above                     |
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
summary(usedcars)
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

Now it is clear that there are many more other types of missing values than NA's

Now as I see that the Car Name is a combination of car brand and model. So, to get just the car manufacturer name the code written below will be helpful as getting only manufacturer name will simply our analysis

```{r}
usedcars <- usedcars %>% mutate(Manufacturer = substr(Name,1,regexpr(" ",Name)-1))
```
The above code will add a new column with name Manufacturer having car brand name in it. I observe that in the new column `Manufacturer` the car manufactured by Land Rover is returned as Land only. To correct `str_replace()` function will be used.

```{r}
usedcars$Manufacturer <- str_replace(df$Manufacturer,"Land","Land-Rover")
```
Now all the data in the `Manufacturer` column is erroe free.


Also, one interesting observation is clearly visible from `summary(usedcars)` is that Mileage is charachter data type format but should be of numeric data type. So we will convert the data type of Mileage by first extracting the number string from the Mileage which look like `"16.63 kmpl"` and then using `as.numeric()` to covert it into numeric data type by running the code shown below:
```{r}
usedcars$Mileage <- as.numeric(substr(usedcars$Mileage,1,regexpr(" ",usedcars$Mileage)-1))
```

Now as our data is manipulated and is converted into desirable data type we can remove missing values using `na.omit(usedcars)` function which will remove all the rows having even a single missing values at the end.<br/>
**(`na.omit()` is not advisable when there are large number of missing values becaue if we do that it may be possible we will be left with less data points not enough to support our analysis)**

## Data Visualisation

Now let's try to find out answer some of the questions from the data.

**Ques1. Which city people majorly put their car on sell.** <br/>

* **No. of cars on sell in different cities of India with Mumbai having maximum number of cars to sell.**

![alt text](https://github.com/MukulParashar/Used_Car_Sell_India/blob/master/images/City%20and%20Cars%20Count.png)

The possible assumption for the above observation can be that as Mumbai being financial capital of country, it's easy for an average person to own a car hence more car are owned by people other than any city but with large population and heavy traffic more and more people are now relying on cab services thus more cars are available in market to sell.

![alt text](https://github.com/MukulParashar/Used-Car-Sell-Market-Analysis/blob/master/images/PercentageCarsLocation1.png)


**2. Which car brands are majorly on sale.**
<br/>
* **The top 10 most selling used cars brands are shown in the plot below where the most selling Maruti Cars among all owner type.**
![alt text](https://github.com/MukulParashar/Used_Car_Sell_India/blob/master/images/top%2010%20brands.png)

**The reason for the above plot can be because of Maruti's less efficient cars as compared to other brands. Other reasons could be unavailability of parts, improper service and many more.**

**But if we do deeper analysis, we can assume that most people are switching from Hyundai Cars in Petrol segment and Maruti Cars in Diesel segment to other cars with the help of the plot shown below**

![alt text](https://github.com/MukulParashar/Used_Car_Sell_India/blob/master/images/Rplot06.png)


**3. Which fuel type and which hand cars are on sell in top 10 brands.**<br/>

![alt text](https://github.com/MukulParashar/Used_Car_Sell_India/blob/master/images/Fuel%20type%20Owner%20type.png)

* **From the above plot we can conclude that electric cars are in least number to resale because less companies has entered Indian market which are manufacturing electric cars.** 

* **We can also assume from above that between two major fuel type cars i.e. Petrol and Diesel, we know that buying a Petrol car is more beneficial for a customer than buying a Diesel car because engine efficiency of Petrol cars is more than Diesel cars that's why less no. of Petrol cars are on resale compared to Diesel cars.**

![alt text](https://github.com/MukulParashar/Used_Car_Sell_India/blob/master/images/Auto.png)

* **Most interesting insight that is found with the data as shown in above plot is that the maximum number of cars which are on resale have manual transmission compared to cars on resale with automatic transmission which manufactured during 2013 and 2017 by which we can assmue that:**

     **1. More people has shifted from cars with manual transmission to automatic transmission due to ease of driving.**<br/>
     <br/>
     **2. Cars manufactured between years 2013 and 2017 can have manufacturing defects.**
    
##### Note: The concluded points will have been more strong if price column has been available. But is not, possible assumptions are made.















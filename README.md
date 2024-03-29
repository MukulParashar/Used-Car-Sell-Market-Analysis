## EDA on used cars data on sell in India 
This repository is an exhaustive analytical report on Used Cars Selling Industry in the major cities of 
India and for that, the supporting data is hypothetical data taken from the `Kaggle`.

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

First we will install the `tidyverse` library and load it on RStudio followed by importing data set as dataframe named `usedcars`. As file is in .xlsx format `readxl` packages will also be installed.

```{r}
install.packages("tidyverse")
library(tidyverse)
install.packages("readxl")
library(readxl)

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

We can observe from the plot below that Mumbai is having maximum number of used cars to sell in which approximately 85% used cars are with first owner, 10% used cars are with second owner and 5% used cars are with third owner.

![alt text](https://github.com/MukulParashar/Used_Car_Sell_India/blob/master/images/City%20and%20Cars%20Count.png)

![alt text](https://github.com/MukulParashar/Used-Car-Sell-Market-Analysis/blob/master/images/PercentageCarsLocation1.png)
<br/>
The possible assumption for the above observation could be that as Mumbai being financial capital of country, it's easy for an average person to own a car hence more car are owned by people other than any city but with large population and heavy traffic more and more people are now relying on cab services thus more cars are available in market for sale.

**Ques2. Which car brands are majorly on sale.**

The top 10 most selling used cars brands are shown in the plot below where the most selling Maruti Cars among all owner type.

![alt text](https://github.com/MukulParashar/Used_Car_Sell_India/blob/master/images/top%2010%20brands.png)

But if we go into deeper analysis, we can observe from the the plot below that Hyundai Cars in Petrol segment and Maruti Cars in Diesel segment are majorly available on sale.

![alt text](https://github.com/MukulParashar/Used_Car_Sell_India/blob/master/images/Rplot06.png)

One possible reason for such market situation is that as Maruti and Hyundai has fairly large market share than other brands due to large number of affordable car models, major population owned these two. But as Maruti launched it's affordable premium cars category Nexa and Hyundai launched it's one of the most affordable SUV Creta, more no. of peoples has put their old maruti and hyundai car on sale and maybe want to own the premium affordable cars in the same brands at almost same price.


**3. Which fuel type and which hand cars are majorly on sale.**

![alt text](https://github.com/MukulParashar/Used_Car_Sell_India/blob/master/images/Fuel%20type%20Owner%20type.png)

From the above plot we can conclude that electric cars are in least number to resale because currently less companies are present Indian market which are manufacturing electric cars. 

Also to explain why petrol and diesel cars are  on sale in large number with the help of supporting plot shown below. It clearly indicates that the milegae of CNG cars is much higher than any other fuel type and also cost of CNG is much cheaper than other fuel types therefore we can make a possible assumption why people are selling more and more petrol and diesel cars.

**(Note: The concluded point above will have been more strong if price column has been available in data set. But is not, possible assumptions are made)**

![alt text](https://github.com/MukulParashar/Used-Car-Sell-Market-Analysis/blob/master/images/milefuelowner.png)

**Ques4. Which year manufactured car are more on resale**

![alt text](https://github.com/MukulParashar/Used_Car_Sell_India/blob/master/images/Auto.png)

Most interesting insight that is found with the data as shown in above plot is that the maximum number of cars which are on resale have manual transmission compared to cars on resale with automatic transmission which manufactured during 2012 and 2018 by which we can assmue that. If we go into deeper analysis as shown in plots below:

![alt text](https://github.com/MukulParashar/Used-Car-Sell-Market-Analysis/blob/master/images/mileTrans.png)


![alt text](https://github.com/MukulParashar/Used-Car-Sell-Market-Analysis/blob/master/images/mile.png)

With the help of above two plots we can clearly obseve that Cars which are manufactured between 2012 and 2018 of manual type has high mileage also we can see cars of CNG fuel type have high mileage.

Therefore we can conclude that the reason behind sell of Diesel and Petrol Cars is that more and more people are maybe switching to Manual transmission CNG type car as it will be really cost effective to the buyer due to high mileage of car at low fuel cost.

**(Note: The concluded points will have been more strong if price column has been available in dataset. But is not, possible assumptions are made.)**















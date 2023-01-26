# CTA-Remodel

I used Chicago-based data to analyze the Chicago Transit Authority (CTA) stations throughout the city of Chicago and nearby suburbs, looking to highlight the city’s most dangerous and ineffective stations. Then, once a target station was picked, I analyzed city blocks and streets near the station to suggest recommendations to increase daily ridership. 


## Data Set (https://drive.google.com/drive/folders/1Q2wHWqyn0CmZDoxIRe0yE4BNswxqCMsJ?usp=sharing): 

I worked with data on the following variables: 

1. Daily ridership
2. Crime
3. Nearby bus stops
4. Nearby bikeshare (Divvy) stops
5. Nearby grocery stores
6. Nearby police stations
7. Nearby public housing

###### After downloading the data and uploading it into pgAdmin, I cleaned the data down significantly. The most notable changes were: 

- All data was cut down to just the time period 2016 - 2022
- Crime data was cleaned to just “relevant” crimes in “relevent” locations (violent crimes that a typical CTA rider would reasonably have to worry about)
- I created a new station-id system through Excel that I then assigned to the train stations, as their specific names varied between datasources
- I removed stations that, as of 2022, are closed and no longer running
- I removed any outliers (data more than 2 standard deviations from the mean)



## Scoring: 

In order to compare various stations, I developed a constant scoring system. Each station received a number based on each variable, which then was summed for a total score out of 13: 
- Daily ridership (The 20 stations with the lowest daily ridership received a score of 4, with the next 20 receiving 3, the next 20 receiving a 2, and so on)
- Crime (The 20 stations with the highest daily crime recieved a score of 3, with the next 20 receiving 2, and so on)
- Bus Stops (The 20 stations with the least nearby bus stops received a score of 2, with the next 20 receiving a 1)
- Bikeshare stops, Grocery stores, Police stations, + Public housing (Only the 30 stations with the lowest amount of the above received a 1, and all other stations received a 0)



## Picking a target station: 

Ultimately, three stations had the highest scores of 10. Of those three, two of which were part of the purple line and located in the city suburbs. They both had 0 reported crime, with their high score a result solely of the stations being in the middle of nowhere. However, the third station, Cicero-Lake, is located on the Green line, and in the middle of one of the most dangerous neighborhoods in Chicago. With double the daily crime and a third of the daily ridership of the average station, it was clear that this was the station that needed some improvements.



## Trends:

Before moving toward recommendations, I made sure to highlight trends in the data that would clarify which changes would actually increase daily ridership. I found that stations nearby more bus stations, bikeshare stations, and grocery options tend to see higher daily ridership than those without.

When looking at the area surrounding the Cicero-Lake station you find that Cicero-Lake has 0 nearby bus stops, 1 nearby bikeshare stations, and 0 nearby grocery stores. The average CTA station has 3 nearby bus stops, 4 nearby bikeshare stations, and 1 nearby grocery store, which likely points to why Cicero-Lake sees a daily ridership of just 852, about ⅓ of the 2,658 daily average across all stations.



## Recommendations:

When looking at the area surrounding the Cicero-Lake station I also noticed a large industrial complex closeby, containing buildings like the CTA training facility and Chicago’s public sanitation building, implying a large amount of low-middle income workers going to and from these locations on a regular basis. 

Understanding this, and in conjunction with the highlighted trends, I recommend 2 new bus stops, 1 on the train station location and 1 located within the industrial area. I recommended 2 new bikeshare stations, with 1 again located within the industrial area and 1 located in a nearby residential area across from a park. Finally, I noticed a large vacant building directly next to the station, and I recommend exploring government-subsidized grocery options. 



## Conclusion:

Based on low ridership, high crime, and low access to bus stops, bikeshare stations, and grocery stores Cicero-Lake was selected as the target station for improvement. I recommend investment in the neighborhood around the Cicero-Lake station, such as  2 new bus stops, 2 new bikeshare stations, and 1 new grocery store, in order to  increase Cicero-Lake’s daily ridership.

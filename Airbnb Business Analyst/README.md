Airbnb Business Analyst Interview Experience:
CTC - 25 LPA

SQL Questions:

1. Retrieve Housing Data from Specific Cities

You’re a data analyst at Airbnb and you’ve been tasked with retrieving housing data from specific cities. You want to find all Airbnb listings in San Francisco and New York that have at least 10 reviews and an average rating equal to or above 4.5.

Tables:
 • listings: listing_id (integer), name (string), city (string), reviews_count (integer)
 • reviews: listing_id (integer), review_id (integer), stars (integer), submit_date (date)

2. Find the Average Number of Guests per Booking in Each City for Airbnb

As an analyst at Airbnb, one of the most useful insights you could provide would be to understand the average number of guests per booking across locations. For this question, we would like you to write a SQL query that will find the average number of guests per booking in each city.

Tables:
 • bookings: booking_id (integer), property_id (integer), guests (integer), booking_date (date)
 • properties: property_id (integer), city (string)

3. Analyzing Click-Through Rates for Airbnb Listing Views and Bookings

The scenario is that Airbnb wants to analyze the click-through conversion rates (CTRs) of their listings. The CTR is calculated by dividing the number of bookings by the number of listing views, giving a proportion of views that resulted in a booking.

Tables:
 • listing_views: view_id (integer), user_id (integer), visit_date (date), listing_id (integer)
 • bookings: booking_id (integer), user_id (integer), booking_date (date), listing_id (integer)

4. Average Vacant Days in 2021 for Active Listings

The strategy team in Airbnb is trying to analyze the impact of Covid-19 during 2021. To do so, they need you to write a query that outputs the average vacant days across the AirBnbs in 2021. Some properties have gone out of business, so you should only analyze rentals that are currently active. Round the results to a whole number.

Assumptions:
 • is_active field equals 1 when the property is active, and 0 otherwise.
 • In cases where the check-in or check-out date is in another year other than 2021, limit the calculation to the beginning or end of the year 2021 respectively.
 • A listing can be active even if there are no bookings throughout the year.

Tables:
 • bookings: listing_id (integer), checkin_date (date), checkout_date (date)
 • listings: listing_id (integer), is_active (integer)
-- 1. Retrieve Housing Data from Specific Cities--
WITH review_tab AS(
	SELECT 
		listing_id, 
		AVG(stars) AS avg_Star
	FROM reviews
	GROUP BY listing_id
)
SELECT 
	lst.listing_id, 
    lst.name, 
    lst.reviews_count, 
    rt.avg_star
FROM listings AS lst
JOIN review_tab AS rt
	ON lst.listing_id = rt.listing_id
WHERE city IN('San Francisco', 'New York')
	AND reviews_count >=10
    AND avg_Star >= 4.5;

-- 2.Find the Average Number of Guests per Booking in Each City for Airbnb --
SELECT 
	city,
    ROUND(AVG(guests)) AS avg_guests
FROM bookings bk
JOIN properties pp
	ON bk.property_id = pp.property_id
GROUP BY city
ORDER BY avg_guests DESC;

-- 3. Analyzing Click-Through Rates for Airbnb Listing Views and Bookings --
WITH views_table AS (
	SELECT 
		listing_id, 
		COUNT(listing_id) AS views
	FROM sql_interview.listing_views
	GROUP BY listing_id
), 
booking_table AS(
	SELECT 
		listing_id, 
		COUNT(booking_id) AS booking
	FROM bookings_ctr
	GROUP BY listing_id
)
SELECT 
	v.listing_id,
	views,
	booking,
    ROUND(booking/views, 3) AS CTR
FROM views_table v
JOIN booking_table b
	ON v.listing_id = b.listing_id
ORDER BY CTR DESC;

-- OR --
SELECT 
    v.listing_id,
    COUNT(DISTINCT v.view_id) AS views,
    COUNT(DISTINCT b.booking_id) AS bookings,
    ROUND(
        COUNT(DISTINCT b.booking_id) * 1.0 / NULLIF(COUNT(DISTINCT v.view_id), 0), 
        3
    ) AS CTR
FROM listing_views v
LEFT JOIN bookings_ctr b
    ON v.listing_id = b.listing_id
GROUP BY v.listing_id
ORDER BY CTR DESC;


-- 4. Average Vacant Days in 2021 for Active Listings --
WITH adjusted_bookings AS (
    SELECT 
        listing_id,
        GREATEST(DATE '2021-01-01', checkin_date) AS start_date,
        LEAST(DATE '2021-12-31', checkout_date) AS end_date
    FROM bookings
    WHERE checkout_date >= '2021-01-01' AND checkin_date <= '2021-12-31'
),
booked_days_per_listing AS (
    SELECT 
        listing_id,
        SUM(DATEDIFF(start_date, end_date)) AS booked_days
    FROM adjusted_bookings
    GROUP BY listing_id
),
active_listings_2021 AS (
    SELECT 
        l.listing_id,
        COALESCE(b.booked_days, 0) AS booked_days,
        365 - COALESCE(b.booked_days, 0) AS vacant_days
    FROM listings l
    LEFT JOIN booked_days_per_listing b 
        ON l.listing_id = b.listing_id
    WHERE l.is_active = 1
)
SELECT 
    ROUND(AVG(vacant_days)) AS avg_vacant_days_2021
FROM active_listings_2021;

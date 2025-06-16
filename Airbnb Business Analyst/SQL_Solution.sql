-- 1. Retrieve Housing Data from Specific Cities--
WITH review_tab AS(
	SELECT listing_id,
		AVG(stars) AS avg_Star
	FROM reviews
	GROUP BY listing_id
)
SELECT lst.listing_id,
	lst.name,
	lst.reviews_count,
	rt.avg_star
FROM listings AS lst
	JOIN review_tab AS rt ON lst.listing_id = rt.listing_id
WHERE city IN('San Francisco', 'New York')
	AND reviews_count >= 10
	AND avg_Star >= 4.5;
-- 2.Find the Average Number of Guests per Booking in Each City for Airbnb --
SELECT city,
	ROUND(AVG(guests)) AS avg_guests
FROM bookings bk
	JOIN properties pp ON bk.property_id = pp.property_id
GROUP BY city
ORDER BY avg_guests DESC;
-- 3. Analyzing Click-Through Rates for Airbnb Listing Views and Bookings --
WITH views_table AS (
	SELECT listing_id,
		COUNT(listing_id) AS views
	FROM sql_interview.listing_views
	GROUP BY listing_id
),
booking_table AS(
	SELECT listing_id,
		COUNT(booking_id) AS booking
	FROM bookings_ctr
	GROUP BY listing_id
)
SELECT v.listing_id,
	views,
	booking,
	ROUND(booking / views, 3) AS CTR
FROM views_table v
	JOIN booking_table b ON v.listing_id = b.listing_id
ORDER BY CTR DESC;
-- OR --
SELECT v.listing_id,
	COUNT(DISTINCT v.view_id) AS views,
	COUNT(DISTINCT b.booking_id) AS bookings,
	ROUND(
		COUNT(DISTINCT b.booking_id) * 1.0 / NULLIF(COUNT(DISTINCT v.view_id), 0),
		3
	) AS CTR
FROM listing_views v
	LEFT JOIN bookings_ctr b ON v.listing_id = b.listing_id
GROUP BY v.listing_id
ORDER BY CTR DESC;
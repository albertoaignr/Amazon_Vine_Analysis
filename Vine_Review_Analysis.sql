-- DELIVERABLE 2 

-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

SELECT * FROM vine_table;

-- 1. filter down total votes 
SELECT *
INTO vine_table_filter
FROM  vine_table
WHERE total_votes >= '20';

-- 2. filter down helpful votes 

SELECT *
INTO vine_filter_votes
FROM vine_table_filter
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >= 0.5;


-- 3. Vine program (paid)

SELECT *
INTO vine_paid
FROM vine_filter_votes
WHERE vine ='Y';

-- 4. Vine program (unpaid)

SELECT *
INTO vine_unpaid
FROM vine_filter_votes
WHERE vine ='N';

-- 5. Nr. Reviews 

SELECT 
COUNT(p.star_rating)+COUNT(u.star_rating) as total_reviews,
COUNT(p.star_rating) as reviews_paid,
COUNT(u.star_rating) as reviews_unpaid,
	(SELECT COUNT(star_rating) FROM vine_paid
	WHERE star_rating = '5') as five_stars_paid,
	(SELECT COUNT(star_rating) FROM vine_unpaid
	WHERE star_rating = '5') as five_stars_unpaid,
   (SELECT COUNT(star_rating) FROM vine_paid
	WHERE star_rating = '5')*100/(COUNT(p.star_rating)) as percentage_paid,
	(SELECT COUNT(star_rating) FROM vine_unpaid
	WHERE star_rating = '5')*100/COUNT(u.star_rating) as percetage_unpaid
FROM vine_paid as p
FULL OUTER JOIN vine_unpaid as u
ON p.vine = u.vine;
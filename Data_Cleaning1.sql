-- Creatig a basic table that I will then modify/clean up trying out new skills

DROP TABLE IF EXISTS consumer_reviews;

CREATE TABLE consumer_reviews (
	id VARCHAR ,
	name VARCHAR,
	asins TEXT,
	brand VARCHAR,
	categories VARCHAR,
	keys VARCHAR,
	manufacturer VARCHAR,
	reviews_date VARCHAR,
	reviews_dateAdded VARCHAR,
	reviews_dateSeen VARCHAR,
	reviews_didPurchase VARCHAR,
	reviews_doRecommend VARCHAR,
	reviews_id VARCHAR,
	reviews_numHelpful INT,
	reviews_rating INT,
	reviews_sourceURLS VARCHAR,
	reviews_text VARCHAR,
	reviews_title VARCHAR,
	reviews_userCity VARCHAR,
	reviews_userProvince VARCHAR,
	reviews_username VARCHAR
);

COPY consumer_reviews
FROM 'C:amazonreviews.csv'
DELIMITER ','
CSV HEADER;

--Ensure data was imported 
SELECT *
FROM consumer_reviews
LIMIT 10; 

--Delete null COLUMNS
ALTER TABLE consumer_reviews
	DROP COLUMN reviews_didpurchase,
	DROP COLUMN reviews_id,
	DROP COLUMN reviews_usercity,
	DROP COLUMN reviews_userprovince;
	
--I will standardize the date of the veiws and then cast as new data type and verify
--my changes by looking at the schema
UPDATE consumer_reviews
SET reviews_date = CAST(reviews_date AS date);
	
--Update data types 
ALTER TABLE consumer_reviews
ALTER COLUMN reviews_date TYPE DATE
ALTER COLUMN reviews_dateadded TYPE TIMESTAMP USING reviews_dateadded::timestamp without time zone;

--Verify changes 
SELECT *
FROM information_schema.columns
WHERE table_name = 'consumer_reviews'




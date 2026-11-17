-- ============================================================================
-- CSE 111 Fall 2026: Project Checkpoint 2 Script
-- Project Title: Music Distribution Database
-- Team Members: Evelyn Lobach , Nathan Roehrig
-- File: Checkpoint2-script.sql
-- ============================================================================

-- ============================================================================
-- SCHEMA MODIFICATIONS SINCE CHECKPOINT 1
-- ============================================================================
-- 1. Foreign Key Restructuring: The checkpoint 1 submission did not predefine 
-- the types of foreign keys, which have since been added.
-- 2. Transactions NULL: Certain foreign keys in the transactions table were
-- changed as transactions should never be removed if an artist or user deletes
-- ============================================================================

-- ============================================================================
-- MEMBER CONTRIBUTIONS SUMMARY (GROUPED AT THE TOP)
-- ============================================================================
-- SECTION 1: SIMPLE STATEMENTS
-- Statement 01: Nathan Roehrig 100%
-- Statement 02: Nathan Roehrig 100%
-- Statement 03: Nathan Roehrig 100%
-- Statement 04: Nathan Roehrig 100%
-- Statement 05: Nathan Roehrig 100%
-- Statement 06: Evelyn Lobach 100%
-- Statement 07: Evelyn Lobach 100%
-- Statement 08: Evelyn Lobach 100%
-- Statement 09: Evelyn Lobach 100%
-- Statement 10: Evelyn Lobach 100%
--
-- SECTION 2: INTERMEDIATE STATEMENTS
-- Statement 11: Nathan Roehrig 100%
-- Statement 12: Nathan Roehrig 100%
-- Statement 13: Nathan Roehrig 100%
-- Statement 14: Nathan Roehrig 100%
-- Statement 15: Nathan Roehrig 100%
-- Statement 16: Evelyn Lobach 100%
-- Statement 17: Evelyn Lobach 100%
-- Statement 18: Evelyn Lobach 100%
-- Statement 19: Evelyn Lobach 100%
-- Statement 20: Evelyn Lobach 100%
--
-- SECTION 3: COMPLEX STATEMENTS
-- Statement 21: Nathan Roehrig 100%
-- Statement 22: Nathan Roehrig 100%
-- Statement 23: Nathan Roehrig 100%
-- Statement 24: Nathan Roehrig 100%
-- Statement 25: Nathan Roehrig 100%
-- Statement 26: Evelyn Lobach 100%
-- Statement 27: Evelyn Lobach 100%
-- Statement 28: Evelyn Lobach 100%
-- Statement 29: Evelyn Lobach 100%
-- Statement 30: Evelyn Lobach 100%
-- ============================================================================

PRAGMA foreign_keys = ON;
.headers on
.mode column


-- ============================================================================
-- SECTION 1: SIMPLE STATEMENTS (Statements 1 to 10)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Statement 1: Posts from the First User
-- Explanation: Retrieves the post timestamp and body for every post by the 
-- first user 
-- ----------------------------------------------------------------------------

SELECT post_timestamp as Timestamp, post_body as Body
FROM Post
WHERE artist_ID = 1;

-- ----------------------------------------------------------------------------
-- Statement 2: Tracks by Length
-- Explanation: Return all tracks sorted by their length
-- ----------------------------------------------------------------------------

SELECT track_ID as ID, track_title as Title, track_length/1000 as "Length (s)"
FROM Track
ORDER BY track_length DESC;

-- ----------------------------------------------------------------------------
-- Statement 3: Insert a New Listener
-- Explanation: Insert in a new listener account to the system with their email
-- ----------------------------------------------------------------------------

INSERT INTO Listener (listener_username, listener_email, listener_bio)
VALUES ("listener_1000", "listener_1000@example.com", "A new user");

-- ----------------------------------------------------------------------------
-- Statement 4: Delete an Artist
-- Explanation: Removes an artist from the database, which will also cascade 
-- delete their tracks, credits, and posts
-- ----------------------------------------------------------------------------

DELETE FROM Artist
WHERE artist_id = 34;

-- ----------------------------------------------------------------------------
-- Statement 5: Return Free Releases
-- Explanation: Retrieves all releases which cost $0 and sorts them by when 
-- they were released
-- ----------------------------------------------------------------------------

SELECT release_title as Title, release_date as Date, release_type as type
FROM MusicRelease
WHERE release_price = 0
ORDER BY release_date;

-- ----------------------------------------------------------------------------
-- Statement 6: Genre Artist Count
-- Explanation: Retrieves the amount of artists under each genre, in sorted order
-- ----------------------------------------------------------------------------

SELECT artist_genre [Genre], COUNT(*) [num_artists]
FROM Artist
GROUP BY Genre
ORDER BY num_artists DESC;

-- ----------------------------------------------------------------------------
-- Statement 7: Artist Recent Transactions
-- Explanation: Retrieves relevant information from transactions involving an 
-- artist from the past 12 months
-- ----------------------------------------------------------------------------

SELECT transaction_timestamp [Timestamp], transaction_amount [Amount], 
transaction_message [Message], listener_username [Listener]
FROM Transactions
WHERE artist_ID = 8 and Timestamp > datetime('now', '-12 months');

-- ----------------------------------------------------------------------------
-- Statement 8: Artist Total Earnings
-- Explanation: Retrieve total earnings for an artist
-- ----------------------------------------------------------------------------

SELECT SUM(transaction_amount) [total]
FROM Transactions
WHERE artist_ID = 8;

-- ----------------------------------------------------------------------------
-- Statement 9: Artist Discography
-- Explanation: Get all releases made by an artist
-- ----------------------------------------------------------------------------

SELECT release_title [Title], release_date [Date]
FROM MusicRelease
WHERE release_artist = 8;

-- ----------------------------------------------------------------------------
-- Statement 10: Update Artist Description
-- Explanation: Updates an artist's description
-- ----------------------------------------------------------------------------

UPDATE Artist
SET artist_bio = 'Amber Harbor creates original indie rock recordings in a home
 studio.'
WHERE artist_ID = 1;

-- ============================================================================
-- SECTION 2: INTERMEDIATE STATEMENTS (Statements 11 to 21)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Statement 11: Artists who work together
-- Explanation: Retrieve all artists (including self) who has been credited on
-- a track by artist 4
-- ----------------------------------------------------------------------------

SELECT DISTINCT a.artist_ID, a.artist_name
FROM Artist AS a
JOIN TrackCredits AS tc ON tc.artist_ID = a.artist_ID
JOIN Track AS t ON t.track_ID = tc.track_ID
JOIN MusicRelease AS r
    ON r.release_title = t.released_on_title
    AND r.release_date = t.released_on_date
WHERE r.release_artist = 4;

-- ----------------------------------------------------------------------------
-- Statement 12: Get Posts Since a Day
-- Explanation: Aggregates all posts by artists and counts how many of them 
-- were posted since July of 2025
-- ----------------------------------------------------------------------------

SELECT artist_ID, COUNT(*) AS post_count
FROM Post
WHERE post_timestamp >= '2025-07-01'
GROUP BY artist_ID;

-- ----------------------------------------------------------------------------
-- Statement 13: Artist Increases Prices
-- Explanation: Updates the price of all releases conditionally based on which
-- artist released it, as a bulk price adjustment
-- ----------------------------------------------------------------------------

UPDATE MusicRelease
SET release_price = release_price + 1
WHERE release_artist = 8;

-- ----------------------------------------------------------------------------
-- Statement 14: Return Highly Following Listeners
-- Explanation: Groups all users and returns only those who follow at least 10 
-- distinct artists
-- ----------------------------------------------------------------------------

SELECT listener_username, COUNT(DISTINCT artist_ID) AS artists_followed
FROM ListenerFollows
GROUP BY listener_username
HAVING COUNT(DISTINCT artist_ID) >= 10;

-- ----------------------------------------------------------------------------
-- Statement 15: Return High Costing Transactions
-- Explanation: Queries the average transaction amounts, and returns all 
-- transactions which costed a higher amount
-- ----------------------------------------------------------------------------

SELECT transaction_id, transaction_amount
FROM Transactions
WHERE transaction_amount > (
    SELECT AVG(transaction_amount)
    FROM Transactions
);

-- ----------------------------------------------------------------------------
-- Statement 16: 
-- Explanation: Get the full credits of a specific track
-- ----------------------------------------------------------------------------

SELECT artist_name [Artist], artist_role [Role]
FROM Artist [a]
JOIN TrackCredits [tc] ON tc.artist_id = a.artist_id
WHERE track_ID = 6;

-- ----------------------------------------------------------------------------
-- Statement 17: Most popular artists
-- Explanation: Get each artist's follower count and display the most popular 
-- first
-- ----------------------------------------------------------------------------

SELECT artist_name, artist_genre, COUNT(listener_username) [Followers]
FROM Artist
NATURAL JOIN ListenerFollows
GROUP BY artist_name
ORDER BY Followers DESC, artist_genre;

-- ----------------------------------------------------------------------------
-- Statement 18: 
-- Explanation: Get the number of genres that a listener likes by looking at 
-- their followed artists
-- ----------------------------------------------------------------------------

SELECT listener_username, COUNT(DISTINCT artist_genre) [num_genres]
FROM Listener
NATURAL JOIN ListenerFollows
NATURAL JOIN Artist
GROUP BY listener_username;

-- ----------------------------------------------------------------------------
-- Statement 19: 
-- Explanation: Get the top 5 highest selling genres based on artist sales
-- ----------------------------------------------------------------------------

SELECT artist_genre, SUM(transaction_amount) [total_amount]
FROM Artist
NATURAL JOIN Transactions
GROUP BY artist_genre
ORDER BY total_amount DESC
LIMIT 5;

-- ----------------------------------------------------------------------------
-- Statement 20: 
-- Explanation: Get all artists who posted music in September 2025
-- ----------------------------------------------------------------------------
SELECT DISTINCT artist_name [ArtistName]
FROM Artist NATURAL JOIN MusicRelease
WHERE release_date LIKE '2025-09%'

-- ============================================================================
-- SECTION 3: COMPLEX STATEMENTS (Statements 21 to 32)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Statement 21: View for artists who collab with one another
-- Explanation: Create a view joining releases, tracks, and track credits to 
-- show which tracks have collabs which whom
-- ----------------------------------------------------------------------------

DROP VIEW IF EXISTS CollaboratingArtists;
CREATE VIEW CollaboratingArtists AS
SELECT DISTINCT r.release_artist AS primary_artist_ID, t.track_ID, 
tc.artist_ID AS credited_artist_ID
FROM MusicRelease AS r
JOIN Track AS t
    ON t.released_on_title = r.release_title
    AND t.released_on_date = r.release_date
JOIN TrackCredits AS tc ON tc.track_ID = t.track_ID
WHERE tc.artist_ID <> r.release_artist;

-- ----------------------------------------------------------------------------
-- Statement 22: Most Posting Artists
-- Explanation: Creates a WITH clause holding the amount of posts made by every
-- artist, and returns the artists who have the most posts
-- ----------------------------------------------------------------------------

WITH ArtistPostCounts AS (
    SELECT a.artist_ID, a.artist_name, COUNT(p.post_id) AS post_count
    FROM Artist AS a
    LEFT JOIN Post AS p ON p.artist_ID = a.artist_ID
    GROUP BY a.artist_ID, a.artist_name
)
SELECT artist_ID, artist_name, post_count
FROM ArtistPostCounts
WHERE post_count = (SELECT MAX(post_count) FROM ArtistPostCounts);

-- ----------------------------------------------------------------------------
-- Statement 23: Automated Collection Updating
-- Explanation: Whenever a transaction is added into the database, the 
-- corresponding release is added to the corresponding user's collection
-- ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS AddPurchasedReleaseToCollection;
CREATE TRIGGER AddPurchasedReleaseToCollection
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO ListenerCollection (listener_username, release_title, 
    release_date)
    VALUES (NEW.listener_username, NEW.release_title, NEW.release_date);
END;

-- ----------------------------------------------------------------------------
-- Statement 24: Query against the collabs view
-- Explanation: Query CollaboratingArtists to see which artist pairs have 
-- collabed more than once
-- ----------------------------------------------------------------------------

SELECT
    MIN(primary_artist_ID, credited_artist_ID) AS artist_1,
    MAX(primary_artist_ID, credited_artist_ID) AS artist_2,
    COUNT(DISTINCT track_ID) AS collaboration_count
FROM CollaboratingArtists
GROUP BY artist_1, artist_2
HAVING COUNT(DISTINCT track_ID) > 1;

-- ----------------------------------------------------------------------------
-- Statement 25: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 26: Most recent post
-- Explanation: Gets each artist's most recent post
-- ----------------------------------------------------------------------------

SELECT artist_name, post_body
FROM (
    SELECT artist_id, MAX(post_timestamp) [latest]
    FROM Post
    GROUP BY artist_id
    HAVING latest IS NOT NULL
) S JOIN Artist ON Artist.artist_id = S.artist_id
JOIN Post ON Post.artist_id = Artist.artist_id 
WHERE post_timestamp = latest;

-- ----------------------------------------------------------------------------
-- Statement 27: Artist supporters
-- Explanation: Get each listener who follows a specific artist name and has 
-- bought music from that artist
-- ----------------------------------------------------------------------------

DROP VIEW IF EXISTS ArtistFollowers;
CREATE VIEW ArtistFollowers AS
SELECT listener_username
FROM ListenerFollows
NATURAL JOIN Artist
WHERE artist_name = 'Amber Orchard';

DROP VIEW IF EXISTS ArtistSupporters;
CREATE VIEW ArtistSupporters AS 
SELECT listener_username
FROM Transactions
NATURAL JOIN Artist
WHERE artist_name = 'Amber Orchard';

SELECT * FROM ArtistFollowers 
INTERSECT 
SELECT * FROM ArtistSupporters;

-- ----------------------------------------------------------------------------
-- Statement 28: Similar artist
-- Explanation: For each artist, gets another artist with the highest overlap 
-- in followers
-- ----------------------------------------------------------------------------

DROP VIEW IF EXISTS OverlappingFollowers;
CREATE VIEW OverlappingFollowers AS
    SELECT COUNT(A.listener_username) [Overlap], A.artist_ID [artist_A], 
    B.artist_ID [artist_B]
    FROM ListenerFollows A 
    JOIN ListenerFollows B ON A.listener_username = B.listener_username
    and A.artist_ID <> B.artist_ID

    GROUP BY A.artist_ID, B.artist_ID
    ORDER BY A.artist_ID ASC, Overlap DESC;

SELECT artist_A, artist_B, Overlap FROM
(
    SELECT *, MAX(o.Overlap)
    FROM OverlappingFollowers [o]
    GROUP BY artist_A
);

-- ----------------------------------------------------------------------------
-- Statement 29: Favorite artists
-- Explanation: For every listener, gets the artist(s) from which they have the most releases in their collection
-- ----------------------------------------------------------------------------
WITH BoughtReleases AS (
SELECT listener_username, release_artist, COUNT(*) [releases]
FROM ListenerCollection NATURAL JOIN MusicRelease
GROUP BY listener_username, release_artist
), 

MaxReleases AS (
SELECT listener_username, MAX(releases) [max_releases]
FROM BoughtReleases
GROUP BY listener_username
)
SELECT listener_username, release_artist
FROM BoughtReleases [b] NATURAL JOIN MaxReleases [m]
WHERE releases = max_releases;
-- ----------------------------------------------------------------------------
-- Statement 30: 
-- Explanation: Finds the best selling release for every month of 2024
-- ----------------------------------------------------------------------------
WITH ReleaseTotals AS
(
    SELECT strftime('%m',transaction_timestamp) [month], release_title, release_date, 
    SUM(transaction_amount) [total]
    FROM MusicRelease NATURAL JOIN Transactions
    WHERE transaction_timestamp LIKE '2024%'
    GROUP BY month, release_title, release_date
),
BestSelling AS
(
    SELECT month, release_title, release_date, MAX(total) [Earnings]
    FROM ReleaseTotals
    GROUP BY month
)
SELECT * FROM BestSelling;



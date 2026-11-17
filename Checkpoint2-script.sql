-- ============================================================================
-- CSE 111 Fall 2026: Project Checkpoint 2 Script
-- Project Title: Music Distribution Database
-- Team Members: 
-- File: Checkpoint2-script.sql
-- ============================================================================

-- ============================================================================
-- SCHEMA MODIFICATIONS SINCE CHECKPOINT 1
-- ============================================================================
-- 1. Foreign Key Restructuring: The checkpoint 1 submission did not predefine 
-- the types of foreign keys, which have since been added.
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
-- Statement 06: 
-- Statement 07: 
-- Statement 08: 
-- Statement 09: 
-- Statement 10: 
--
-- SECTION 2: INTERMEDIATE STATEMENTS
-- Statement 11: Nathan Roehrig 100%
-- Statement 12: Nathan Roehrig 100%
-- Statement 13: Nathan Roehrig 100%
-- Statement 14: Nathan Roehrig 100%
-- Statement 15: Nathan Roehrig 100%
-- Statement 16: 
-- Statement 17: 
-- Statement 18: 
-- Statement 19: 
-- Statement 20: 
--
-- SECTION 3: COMPLEX STATEMENTS
-- Statement 21: Nathan Roehrig 100%
-- Statement 22: Nathan Roehrig 100%
-- Statement 23: Nathan Roehrig 100%
-- Statement 24: Nathan Roehrig 100%
-- Statement 25: Nathan Roehrig 100%
-- Statement 26: 
-- Statement 27: 
-- Statement 28: 
-- Statement 29: 
-- Statement 30: 
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
-- Statement 6: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 7: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 8: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 9: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 10: 
-- Explanation: 
-- ----------------------------------------------------------------------------


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
-- Statement 13: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 14: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 15: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 16: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 17: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 18: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 19: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 20: 
-- Explanation: 
-- ----------------------------------------------------------------------------


-- ============================================================================
-- SECTION 3: COMPLEX STATEMENTS (Statements 22 to 32)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Statement 21: View for artists who collab with one another
-- Explanation: Create a view joining releases, tracks, and track credits to 
-- show which tracks have collabs which whom
-- ----------------------------------------------------------------------------

DROP VIEW IF EXISTS Collaborating Artists;
CREATE VIEW Collaborating Artists
SELECT DISTINCT r.release_artist AS primary_artist_ID, t.track_ID, 
tc.artist_ID AS credited_artist_ID
FROM MusicRelease AS r
JOIN Track AS t
    ON t.released_on_title = r.release_title
    AND t.released_on_date = r.release_date
JOIN TrackCredits AS tc ON tc.track_ID = t.track_ID
WHERE tc.artist_ID <> r.release_artist;

-- ----------------------------------------------------------------------------
-- Statement 22: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 23: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 24: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 25: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 26: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 27: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 28: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 29: 
-- Explanation: 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Statement 30: 
-- Explanation: 
-- ----------------------------------------------------------------------------


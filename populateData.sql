DELETE FROM Artist;
DELETE FROM Listener;
DELETE FROM ListenerCollection;
DELETE FROM ListenerFollows;
DELETE FROM MusicRelease;
DELETE FROM Post;
DELETE FROM Track;
DELETE FROM TrackCredits;
DELETE FROM Transactions;

.import --csv --skip 1 synthetic_data/Artist.csv Artist
.import --csv --skip 1 synthetic_data/Listener.csv Listener
.import --csv --skip 1 synthetic_data/ListenerCollection.csv ListenerCollection
.import --csv --skip 1 synthetic_data/ListenerFollows.csv ListenerFollows
.import --csv --skip 1 synthetic_data/MusicRelease.csv MusicRelease
.import --csv --skip 1 synthetic_data/Post.csv Post
.import --csv --skip 1 synthetic_data/Track.csv Track
.import --csv --skip 1 synthetic_data/TrackCredits.csv TrackCredits
.import --csv --skip 1 synthetic_data/Transactions.csv Transactions

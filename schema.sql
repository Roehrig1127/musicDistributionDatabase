CREATE TABLE Listener (
    listener_username VARCHAR(100) PRIMARY KEY,
    listener_email VARCHAR(100) NOT NULL,
    listener_bio VARCHAR(500)
);


CREATE TABLE Artist (
    artist_ID INTEGER PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL,
    artist_email VARCHAR(100) NOT NULL,
    artist_bio VARCHAR(500),
    artist_genre VARCHAR(100)
);

CREATE TABLE ListenerFollows (
    listener_username VARCHAR(100),
    artist_ID INTEGER,
    FOREIGN KEY (listener_username) REFERENCES Listener(listener_username) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (artist_ID) REFERENCES Artist(artist_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE MusicRelease (
    release_title VARCHAR(100),
    release_date DATETIME,
    release_description VARCHAR(500),
    release_price DECIMAL(5,2) NOT NULL,
    release_type VARCHAR(10),
    
    release_artist INTEGER,
    PRIMARY KEY(release_title, release_date),
    FOREIGN KEY (release_artist) REFERENCES Artist(artist_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Track (
    track_ID INTEGER PRIMARY KEY,
    track_title VARCHAR(100) NOT NULL,
    track_description VARCHAR(500),
    track_length INTEGER, --In milliseconds
    track_lyrics TEXT,
    
    released_on_title VARCHAR(100),
    released_on_date DATETIME,
    FOREIGN KEY (released_on_title, released_on_date) REFERENCES MusicRelease(release_title, release_date) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ListenerCollection (
    listener_username VARCHAR(100),
    release_title VARCHAR(100),
    release_date DATETIME,

    FOREIGN KEY (listener_username) REFERENCES Listener(listener_username) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (release_title, release_date) REFERENCES MusicRelease(release_title, release_date) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE TrackCredits (
    artist_role VARCHAR(100),
    track_ID INTEGER,
    
    artist_ID INTEGER,
    FOREIGN KEY (track_ID) REFERENCES Track(track_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (artist_ID) REFERENCES Artist(artist_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Transactions ( -- transaction is a key word, needed to pluralize 
    transaction_id INTEGER PRIMARY KEY,
    transaction_timestamp DATETIME NOT NULL,
    transaction_amount DECIMAL(5,2) NOT NULL,
    transaction_message TEXT,
    
    artist_ID INTEGER,
    listener_username VARCHAR(100),
    release_title VARCHAR(100),
    release_date DATETIME,
    FOREIGN KEY (artist_ID) REFERENCES Artist(artist_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (listener_username) REFERENCES Listener(listener_username) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (release_title, release_date) REFERENCES MusicRelease(release_title, release_date) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Post (
    post_id INTEGER PRIMARY KEY,
    post_timestamp DATETIME NOT NULL,
    post_body TEXT,
    
    artist_ID INTEGER,
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id) ON UPDATE CASCADE ON DELETE CASCADE
);
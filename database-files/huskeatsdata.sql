DROP DATABASE IF EXISTS huskeats;
CREATE DATABASE huskeats;
USE huskeats;

CREATE TABLE User (
   user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   email VARCHAR(100) NOT NULL UNIQUE,
   last_use_date DATE,
   active_status BOOLEAN
);

CREATE TABLE Restaurant_Profile (
   restaurant_id INTEGER PRIMARY KEY AUTO_INCREMENT,
   name TEXT NOT NULL,
   address TEXT NOT NULL,
   image TEXT,
   description TEXT,
   promotional_image TEXT,
   menu_image TEXT,
   hours TEXT NOT NULL,
   approval_status BOOLEAN NOT NULL
);

CREATE TABLE Tag (
   tag_id INTEGER PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Review (
   review_id INTEGER PRIMARY KEY AUTO_INCREMENT,
   user_id INTEGER,
   restaurant_id INTEGER,
   title TEXT,
   rating INT CHECK (rating BETWEEN 1 AND 5),
   content TEXT,
   image TEXT,
   date_reported TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES User(user_id)
       ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT fk_review_restaurant FOREIGN KEY (restaurant_id) REFERENCES Restaurant_Profile(restaurant_id)
       ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Comment (
   comment_id INTEGER PRIMARY KEY AUTO_INCREMENT,
   content TEXT NOT NULL,
   review_id INTEGER,
   user_id INTEGER,
   date_reported TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   CONSTRAINT fk_comment_review FOREIGN KEY (review_id) REFERENCES Review(review_id)
       ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT fk_comment_user FOREIGN KEY (user_id) REFERENCES User(user_id)
       ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Admin (
   admin_id INTEGER PRIMARY KEY AUTO_INCREMENT,
   admin_name VARCHAR(50),
   admin_email VARCHAR(50) UNIQUE
);

CREATE TABLE Advertiser (
   advertiser_id INTEGER PRIMARY KEY AUTO_INCREMENT,
   advertiser_email VARCHAR(50) NOT NULL UNIQUE,
   advertiser_name VARCHAR(50)
);

CREATE TABLE Advertisement (
   advertisement_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    advertiser_id INTEGER,
   content TEXT,
   active_start_date DATE,
   active_end_date DATE,
   type TEXT,
   views INT DEFAULT 0,
   clicks INT DEFAULT 0,
   total_cost DECIMAL(10,2),
   CONSTRAINT fk_advertisement_advertiser FOREIGN KEY (advertiser_id) REFERENCES Advertiser(advertiser_id)
       ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Ad_Space (
   ad_space_id INTEGER PRIMARY KEY AUTO_INCREMENT,
   purchased_status BOOLEAN DEFAULT FALSE,
   cost DECIMAL(10,2),
   advertisement_id INTEGER,
   CONSTRAINT fk_adspace_ad FOREIGN KEY (advertisement_id) REFERENCES Advertisement(advertisement_id)
       ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE UserFollows (
   follower_id INTEGER,
   following_id INTEGER,
   PRIMARY KEY (follower_id, following_id),
   CONSTRAINT fk_user_follows_follower FOREIGN KEY (follower_id) REFERENCES User(user_id)
       ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT fk_user_follows_following FOREIGN KEY (following_id) REFERENCES User(user_id)
       ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Restaurant_Tags (
   restaurant_id INTEGER,
   tag_id INTEGER,
   PRIMARY KEY (restaurant_id, tag_id),
   CONSTRAINT fk_restaurant_tags_restaurant FOREIGN KEY (restaurant_id) REFERENCES Restaurant_Profile(restaurant_id)
       ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT fk_restaurant_tags_tag FOREIGN KEY (tag_id) REFERENCES Tag(tag_id)
       ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE User_Favorites (
    user_id INTEGER,
    restaurant_id INTEGER,
    PRIMARY KEY (user_id, restaurant_id),
    CONSTRAINT fk_user_favorites_user FOREIGN KEY (user_id) REFERENCES User(user_id)
                            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_user_favorites_restaurant FOREIGN KEY (restaurant_id) REFERENCES Restaurant_Profile(restaurant_id)
                            ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Reported_Comments (
    user_id INTEGER,
    comment_id INTEGER,
    PRIMARY KEY (user_id, comment_id),
    CONSTRAINT fk_reported_comments_user FOREIGN KEY (user_id) REFERENCES User(user_id)
                            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reported_comments_comment FOREIGN KEY (comment_id) REFERENCES Comment(comment_id)
                            ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Reported_Reviews (
    user_id INTEGER,
    review_id INTEGER,
    PRIMARY KEY (user_id, review_id),
    CONSTRAINT fk_reported_reviews_user FOREIGN KEY (user_id) REFERENCES User(user_id)
                            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reported_reviews_review FOREIGN KEY (review_id) REFERENCES Review(review_id)
                            ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO User(user_id, first_name, last_name, email, last_use_date, active_status)
VALUES
    (10017054, 'Alice', 'Johnson', 'alice@example.com', '2024-03-10', 1),
    (10017828, 'Bob', 'Smith', 'bob@example.com', '2024-03-15', 1),
    (10014563, 'Charlie', 'Brown', 'charlie@example.com', '2024-03-12', 0);


INSERT INTO Restaurant_Profile(restaurant_id, name, address, image, description, promotional_image, menu_image, hours, approval_status)
VALUES
(2345, 'Pasta Palace', '123 Main St', NULL, 'Italian Cuisine', NULL, NULL, '10:00:00', 1),
(5677, 'Burger Haven', '456 Elm St', NULL, 'Best burgers in town', NULL, NULL, '11:00:00', 1),
(8894, 'Sushi Spot', '789 Pine St', NULL, 'Authentic Japanese Sushi', NULL, NULL, '09:30:00', 1);

INSERT INTO Tag (tag_id, name)
VALUES
    (3, 'Italian'),
    (5 ,'Fast Food'),
    (12, 'Japanese');

INSERT INTO Review (review_id, user_id, restaurant_id, title, rating, content, image)
VALUES
(1, 10017054, 2345, 'Great Pasta!', 5, 'Loved the food and the ambiance.', NULL),
(2, 10017828, 5677, 'Not bad', 3, 'Decent burgers but slow service.', NULL),
(3, 10014563, 8894, 'Fresh sushi', 4, 'The sushi was really fresh and well-prepared.', NULL);

INSERT INTO Comment (comment_id, content, review_id, user_id)
VALUES
(444, 'I agree, the pasta is amazing!', 1, 10017054),
(555, 'I had a different experience, service was fast!', 2, 10017828),
(666, 'I want to try this place now!', 3, 10014563);

INSERT INTO Admin (admin_id, admin_name, admin_email)
VALUES
(123, 'Admin1', 'admin1@example.com'),
(344, 'Admin2', 'admin2@example.com');

INSERT INTO Advertiser (advertiser_id, advertiser_email, advertiser_name)
VALUES
(1111, 'ads1@example.com', 'Marketing Corp'),
(2234, 'ads2@example.com', 'Ad Agency Inc.');

INSERT INTO Advertisement (advertisement_id, content, active_start_date, active_end_date, type, total_cost, advertiser_id)
VALUES
(6578, 'Limited time offer-20% off textbooks', '2024-03-01', '2024-04-01', 'Banner', 100.00, 1111),
(4564, 'Get 20% off burgers!', '2024-03-05', '2024-05-05', 'Sidebar', 50.00,  2234);

INSERT INTO Ad_Space (ad_space_id, cost, advertisement_id)
VALUES
(1, 100.00, 6578),
(0, 50.00, 4564);

INSERT INTO UserFollows (follower_id, following_id)
VALUES
(10017054, 10017828),
(10017828, 10017054),
(10014563, 10017828);

INSERT INTO Restaurant_Tags(restaurant_id, tag_id)
VALUES
(2345, 3),
(5677, 5),
(8894, 12);

INSERT INTO User_Favorites (user_id, restaurant_id)
VALUES
    (10017054, 2345),
    (10017828, 5677),
    (10014563, 8894),
    (10017054, 8894),
    (10017828, 2345);

INSERT INTO Reported_Comments (user_id, comment_id)
VALUES
    (10017054, 555),
    (10017828, 666),
    (10014563, 444);

INSERT INTO Reported_Reviews (user_id, review_id)
VALUES
    (10017828, 1),
    (10014563, 2),
    (10017054, 3);





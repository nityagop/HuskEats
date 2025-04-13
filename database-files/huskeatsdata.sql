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
(4526, 'Ulrika', 'Dansken', '2024-09-27', 1);
(9036, 'Delilah', 'Stollery', '2025-04-25', 0);
(9168, 'Mariele', 'Flawn', '2024-05-26', 1);
(7097, 'Temple', 'Philps', '2025-04-06', 0);
(5604, 'Molli', 'Tebbett', '2025-01-30', 0);
(9909, 'Vivie', 'Bruckenthal', '2024-12-28', 1);
(5971, 'Olympe', 'Warner', '2024-07-04', 1);
(8858, 'Rocky', 'Kench', '2025-01-24', 1);
(8256, 'Gerek', 'Grierson', '2025-04-22', 1);
(4740, 'Flossi', 'Ambrosetti', '2024-06-21', 1);
(2006, 'Roxana', 'Presley', '2025-01-25', 1);
(2101, 'Marcelline', 'Martinon', '2025-04-20', 0);
(5526, 'Darcy', 'Glaysher', '2024-08-14', 0);
(9064, 'Isac', 'Overlow', '2024-08-05', 0);
(7326, 'Brooke', 'Standeven', '2024-12-31', 0);
(9822, 'Kimberlyn', 'Bohlsen', '2024-06-06', 0);
(7722, 'Horace', 'Bake', '2024-10-07', 0);
(5147, 'Bary', 'Schwander', '2024-12-25', 1);
(3122, 'Esther', 'Hurdle', '2024-07-21', 0);
(1224, 'Viole', 'Clouter', '2024-05-10', 0);
(8946, 'Linzy', 'Casella', '2024-04-17', 1);
(4504, 'Bride', 'Children', '2024-07-28', 1);
(4954, 'Idalia', 'Thrift', '2024-12-28', 0);
(9091, 'Codee', 'Huxley', '2024-05-24', 1);
(2304, 'Sheridan', 'Kerwood', '2024-08-13', 0);
(6384, 'Crysta', 'Trump', '2024-06-12', 1);
(8106, 'Gifford', 'Aldcorne', '2024-09-05', 1);
(9443, 'Edyth', 'Wylam', '2024-12-08', 1);
(3934, 'Cyndie', 'Vacher', '2024-06-15', 0);
(6657, 'Robbyn', 'Caddie', '2024-11-28', 1);
(6157, 'Merridie', 'Waterson', '2025-04-28', 1);
(9849, 'Rozanna', 'Jensen', '2024-07-08', 0);
(4695, 'Penni', 'Tidy', '2024-12-18', 1);
(3116, 'Lorelei', 'Skeleton', '2024-10-11', 1);
(2422, 'Jameson', 'Ducarel', '2024-12-19', 1);
(2129, 'Tandi', 'Rothon', '2024-07-02', 0);
(9771, 'Fulton', 'Rainbow', '2024-08-21', 1);
(1417, 'Fabian', 'Neilan', '2025-01-02', 1);
(5923, 'Cathie', 'Foggarty', '2025-02-05', 1);
(4680, 'Conrad', 'Jay', '2025-03-16', 1);



INSERT INTO Restaurant_Profile(restaurant_id, name, address, image, description, promotional_image, menu_image, hours, approval_status)
VALUES
(7768, 'The Hungry Panda', '23318 Morningstar Junction', NULL, 'porttitor lorem id ligula', NULL, NULL, '6:59 PM', 0),  
(6242, 'Sizzle & Spice', '407 Orin Trail', NULL, 'morbi vel lectus in', NULL, NULL, '8:52 PM', 1),
(3305, 'Cafe Delight', '9066 Eagle Crest Plaza', NULL, 'ac consequat metus sapien ut', NULL, NULL, '8:21 PM', 0),
(1830, 'Bella Italia', '6 Maywood Lane', NULL, 'quis orci', NULL, NULL, '9:27 PM', 1),
(3107, 'The Golden Spoon', '056 American Ash Pass', NULL, 'donec diam', NULL, NULL, '11:50 PM', 0),
(5745, 'Flavors of India', '8069 Kinsman Circle', NULL, 'sollicitudin vitae consectetuer', NULL, NULL, '7:13 PM', 0),
(3424, 'Taste of Tokyo', '4 Melrose Hill', NULL, 'sapien iaculis congue vivamus', NULL, NULL, '7:06 PM', 1),
(3314, 'Mama Mia''s Kitchen', '92219 Springview Point', NULL, 'justo sollicitudin ut', NULL, NULL, '11:37 PM', 1),
(7104, 'The Rustic Fork', '49 Hazelcrest Court', NULL, 'amet sem fusce consequat', NULL, NULL, '11:38 PM', 0),
(3189, 'Sunset Grill', '63 Golf Course Terrace', NULL, 'id luctus', NULL, NULL, '7:59 PM', 0),
(2381, 'The Hungry Panda', '2 Mccormick Alley', NULL, 'pede justo', NULL, NULL, '6:13 PM', 0),
(4489, 'Sizzle & Spice', '1 Holy Cross Terrace', NULL, 'turpis a pede posuere', NULL, NULL, '8:03 PM', 0),
(4825, 'Cafe Delight', '9005 Oriole Avenue', NULL, 'neque sapien placerat', NULL, NULL, '8:37 PM', 0),
(3746, 'Bella Italia', '142 East Parkway', NULL, 'maecenas rhoncus aliquam lacus', NULL, NULL, '8:08 PM', 1),
(5802, 'The Golden Spoon', '44799 Farwell Trail', NULL, 'neque sapien', NULL, NULL, '9:32 PM', 1),
(8544, 'Flavors of India', '25943 Sutherland Avenue', NULL, 'et eros vestibulum ac', NULL, NULL, '10:41 PM', 1),
(4591, 'Taste of Tokyo', '6058 Brown Trail', NULL, 'libero rutrum', NULL, NULL, '8:47 PM', 1),
(2102, 'Mama Mia''s Kitchen', '1462 Claremont Drive', NULL, 'augue luctus tincidunt', NULL, NULL, '11:52 PM', 1),
(9979, 'The Rustic Fork', '503 Fulton Place', NULL, 'curae mauris viverra diam vitae', NULL, NULL, '6:36 PM', 1),
(9979, 'Sunset Grill', '65 Mockingbird Parkway', NULL, 'ut tellus nulla ut', NULL, NULL, '9:32 PM', 0),
(4777, 'The Hungry Panda', '75323 John Wall Road', NULL, 'cursus id turpis', NULL, NULL, '8:01 PM', 1),
(4876, 'Sizzle & Spice', '4 5th Plaza', NULL, 'non mi integer ac neque', NULL, NULL, '8:48 PM', 0),
(7428, 'Cafe Delight', '05 Park Meadow Center', NULL, 'ac tellus semper', NULL, NULL, '8:01 PM', 1),
(4472, 'Bella Italia', '7 Birchwood Way', NULL, 'eu interdum eu tincidunt in', NULL, NULL, '6:22 PM', 0),
(2056, 'The Golden Spoon', '90209 Dryden Park', NULL, 'elementum nullam varius nulla', NULL, NULL, '6:28 PM', 0),
(5054, 'Flavors of India', '907 Elka Lane', NULL, 'lectus pellentesque eget nunc', NULL, NULL, '7:04 PM', 0),
(5099, 'Taste of Tokyo', '5 Grim Way', NULL, 'turpis a pede', NULL, NULL, '9:53 PM', 0),
(2101, 'Mama Mia''s Kitchen', '57140 Butternut Pass', NULL, 'eleifend quam a', NULL, NULL, '6:27 PM', 0),
(4860, 'The Rustic Fork', '854 Mosinee Crossing', NULL, 'tincidunt eu felis fusce', NULL, NULL, '9:48 PM', 1),
(3608, 'Sunset Grill', '518 Summit Junction', NULL, 'integer non velit donec diam', NULL, NULL, '9:31 PM', 0),
(6293, 'The Hungry Panda', '2953 Gulseth Lane', NULL, 'non pretium quis lectus', NULL, NULL, '6:48 PM', 1),
(8583, 'Sizzle & Spice', '83 Dwight Hill', NULL, 'ultrices vel', NULL, NULL, '7:22 PM', 1),
(1526, 'Cafe Delight', '1 Tennyson Circle', NULL, 'habitasse platea dictumst maecenas', NULL, NULL, '9:42 PM', 0),
(2194, 'Bella Italia', '41 Lukken Junction', NULL, 'tortor duis', NULL, NULL, '11:14 PM', 1),
(1234, 'The Golden Spoon', '7666 Meadow Vale Pass', NULL, 'volutpat quam', NULL, NULL, '11:03 PM', 1),
(9734, 'Flavors of India', '73444 Loomis Street', NULL, 'curabitur convallis', NULL, NULL, '8:31 PM', 0),
(2304, 'Taste of Tokyo', '2797 Mayer Circle', NULL, 'pellentesque eget nunc donec quis', NULL, NULL, '11:29 PM', 0),
(5576, 'Mama Mia''s Kitchen', '897 Carberry Junction', NULL, 'posuere cubilia curae duis', NULL, NULL, '10:14 PM', 1),
(5647, 'The Rustic Fork', '32157 Division Pass', NULL, 'tincidunt nulla mollis molestie', NULL, NULL, '8:48 PM', 0),
(8372, 'Sunset Grill', '5863 Bunker Hill Street', NULL, 'libero rutrum', NULL, NULL, '9:57 PM', 1);


INSERT INTO Tag (tag_id, name)
VALUES
(1, 'Italian'),
(2, 'Mexican'),
(3, 'Japanese'),
(4, 'Indian'),
(5, 'French'),
(6, 'Greek'),
(7, 'Thai'),
(8, 'Chinese'),
(9, 'Mediterranean'),
(10, 'American'),
(11, 'Vietnamese'),
(12, 'Korean'),
(13, 'Brazilian'),
(14, 'Spanish'),
(15, 'German'),
(16, 'Moroccan'),
(17, 'Turkish'),
(18, 'Peruvian'),
(19, 'Argentinian'),
(20, 'Russian'),
(21, 'Australian'),
(22, 'Ethiopian'),
(23, 'Swedish'),
(24, 'Lebanese'),
(25, 'Irish'),
(26, 'Cuban')
(27, 'Hawaiian'),
(28, 'Filipino'),
(29, 'Belgian'),
(30, 'Jamaican'),
(31, 'Malaysian'),
(32, 'Portuguese'),
(33, 'Scottish'),
(34, 'Tibetan'),
(35, 'Ukrainian'),
(36, 'Polish'),
(37, 'Czech'),
(38, 'Canadian'),
(39, 'South African'),
(40, 'Italian');

INSERT INTO Review (review_id, user_id, restaurant_id, title, rating, content, image)
VALUES
(1, 4526, 7768, 'quam a odio', 5, 'ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique', 'NULL');
(2, 9168, 6242, 'dolor sit amet consectetuer', 4, 'montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque', 'NULL');
(3, 7097, 3305, 'hac habitasse platea', 5, 'ultrices libero non mattis pulvinar nulla', 'NULL');
(4, 5604, 1830, 'sem duis aliquam convallis', 5, 'dapibus nulla suscipit ligula in lacus curabitur at ipsum', 'NULL');
(5, 9909, 3107, 'diam vitae quam suspendisse', 4, 'cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque', 'NULL');
(6, 5971, 5745, 'penatibus et magnis dis', 5, 'sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus', 'NULL');
(7, 8858, 3424, 'sit amet eleifend pede libero', 5, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan', 'NULL');
(8, 8256, 3314, 'sed lacus morbi sem', 3, 'convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus', 'NULL');
(9, 4740, 7104, 'in felis eu', 2, 'maecenas ut massa quis augue luctus tincidunt nulla', 'NULL');
(10, 2006, 3189, 'nisl duis bibendum felis sed', 1, 'potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient', 'NULL');
(11, 2101, 2381, 'suspendisse accumsan tortor', 1, 'turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam', 'NULL');
(12, 5526, 4489, 'velit vivamus vel nulla', 1, 'at lorem integer tincidunt ante vel ipsum praesent blandit', 'NULL');
(13, 9064, 4825, 'purus sit amet nulla', 5, 'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus', 'NULL');
(14, 7326, 3746, 'ac lobortis vel dapibus', 4, 'at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet', 'NULL');
(15, 9822, 5802, 'suspendisse potenti cras in', 3, 'eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet', 'NULL');
(16, 7722, 8544, 'nunc proin at turpis a', 1, 'penatibus et magnis dis parturient', 'NULL');
(17, 5147, 4591, 'in hac habitasse', 5, 'odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui', 'NULL');
(18, 3122, 2102, 'ullamcorper purus sit amet', 2, 'diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus', 'NULL');
(19, 1224, 9979, 'quisque porta volutpat erat', 4, 'lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis', 'NULL');
(20, 8946, 9979, 'ut dolor morbi vel', 2, 'integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare', 'NULL');
(21, 4504, 4876, 'in imperdiet et', 4, 'erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in', 'NULL');
(22, 4954, 7428, 'magna ac consequat metus sapien', 1, 'id ligula suspendisse ornare consequat lectus', 'NULL');
(23, 9091, 4472, 'potenti cras in', 4, 'magna at nunc commodo placerat praesent blandit nam nulla integer pede', 'NULL');
(24, 2304, 2056, 'vel nisl duis ac nibh', 1, 'quis augue luctus tincidunt nulla mollis molestie', 'NULL');
(25, 6384, 5054, 'elementum nullam varius', 1, 'dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius', 'NULL');
(26, 8106, 5099, 'tellus semper interdum', 5, 'eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis', 'NULL');
(27, 9443, 2101, 'at lorem integer', 3, 'dui maecenas tristique est et tempus semper est quam pharetra magna', 'NULL');
(28, 3934, 4860, 'fringilla rhoncus mauris', 4, 'congue eget semper rutrum nulla nunc purus', 'NULL');
(29, 6657, 3608, 'quisque id justo sit', 1, 'convallis morbi odio odio elementum eu interdum', 'NULL');
(30, 6157, 6293, 'vestibulum ante ipsum', 4, 'nulla mollis molestie lorem quisque ut', 'NULL');
(31, 9849, 8583, 'suspendisse accumsan tortor quis', 5, 'sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus', 'NULL');
(32, 4695, 1526, 'vestibulum eget vulputate', 4, 'integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel', 'NULL');
(33, 3116, 2194, 'nec sem duis aliquam', 4, 'neque sapien placerat ante nulla justo aliquam quis', 'NULL');
(34, 2422, 1234, 'sapien cum sociis natoque', 5, 'mauris viverra diam vitae quam suspendisse potenti', 'NULL');
(35, 2129, 9734, 'vel augue vestibulum ante', 3, 'cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue', 'NULL');
(36, 9771, 2304, 'hac habitasse platea', 3, 'in imperdiet et commodo vulputate justo in blandit', 'NULL');
(37, 1417, 5576, 'est congue elementum', 1, 'faucibus cursus urna ut tellus nulla ut', 'NULL');
(38, 5923, 5647, 'justo etiam pretium', 4, 'porttitor lacus at turpis donec posuere metus vitae ipsum', 'NULL');
(39, 4680, 8372, 'nonummy integer non velit', 4, 'at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus', 'NULL');
(40, 9036, 7768, 'porttitor lorem id ligula', 5, 'id nisl venenatis lacinia aenean sit amet justo morbi', 'NULL');

INSERT INTO Comment (comment_id, content, review_id, user_id)
VALUES
(1, 'non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum', 1, '5604'),
(2, 'consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum', 2, '9822'),
(3, 'duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque', 3, '6384'),
(4, 'sit amet lobortis sapien sapien non mi integer ac neque duis bibendum', 4, '5971'),
(5, 'felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo', 5, '1417'),
(6, 'ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl', 6, '9822'),
(7, 'lorem ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius', 7, '5923'),
(8, 'arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor eu pede', 8, '9849'),
(9, 'porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor', 9, '9064'),
(10, 'tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea', 10, '1417'),
(11, 'sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam', 11, '4740'),
(12, 'vulputate elementum nullam varius nulla facilisi cras non velit nec nisi', 12, '3116'),
(13, 'cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam', 13, '9909'),
(14, 'eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare', 14, '4526'),
(15, 'tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi', 15, '9909'),
(16, 'quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac', 16, '3116'),
(17, 'risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl', 17, '9091'),
(18, 'mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus', 18, '1224'),
(19, 'suspendisse potenti cras in purus eu magna vulputate luctus cum sociis', 19, '9443'),
(20, 'sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus', 20, '7326'),
(21, 'in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec', 21, '4740'),
(22, 'nisi volutpat eleifend donec ut dolor morbi vel lectus in', 22, '8946'),
(23, 'convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi', 23, '9443'),
(24, 'odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae', 24, '9168'),
(25, 'praesent blandit lacinia erat vestibulum sed magna at nunc commodo', 25, '1224'),
(26, 'eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui', 26, '9064'),
(27, 'eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor', 27, '6657'),
(28, 'pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur', 28, '9443'),
(29, 'orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum', 29, '9168'),
(30, 'eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium', 30, '1417'),
(31, 'nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla', 31, '3934'),
(32, 'parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes', 32, '9443'),
(33, 'imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet', 33, '8106'),
(34, 'maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in', 34, '5923'),
(35, 'mauris sit amet eros suspendisse accumsan tortor quis turpis sed', 35, '1224'),
(36, 'bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce', 36, '4526'),
(37, 'elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur', 37, '4680'),
(38, 'non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae', 38, '2422'),
(39, 'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet', 39, '2422'),
(40, 'egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu', 40, '4954');


INSERT INTO Admin (admin_id, admin_name, admin_email)
VALUES
(1, 'Darryl Boor', 'dboor0@dmoz.org'),
(2, 'Andrey Agus', 'aagus1@auda.org.au'),
(3, 'Moria Longridge', 'mlongridge2@cloudflare.com'),
(4, 'Richmound McGarrie', 'rmcgarrie3@globo.com'),
(5, 'Megan Cosham', 'mcosham4@howstuffworks.com'),
(6, 'Henrieta Provis', 'hprovis5@webnode.com'),
(7, 'Royce Yockney', 'ryockney6@scientificamerican.com'),
(8, 'Carine Hamsson', 'chamsson7@vk.com'),
(9, 'Aidan Kenen', 'akenen8@businessweek.com'),
(10, 'Osbourne Cohalan', 'ocohalan9@php.net'),
(11, 'Biron Strangward', 'bstrangwarda@t.co'),
(12, 'Rice Houlahan', 'rhoulahanb@edublogs.org'),
(13, 'Kate Louche', 'klouchec@gmpg.org'),
(14, 'Dorelia Ladson', 'dladsond@163.com'),
(15, 'Hailee McKeaney', 'hmckeaneye@nydailynews.com'),
(16, 'Julee Pickrell', 'jpickrellf@unc.edu'),
(17, 'Ralph Willstrop', 'rwillstropg@ucoz.ru'),
(18, 'Bertha Geake', 'bgeakeh@usnews.com'),
(19, 'Concordia Bastone', 'cbastonei@dailymotion.com'),
(20, 'Lucio Dovydenas', 'ldovydenasj@cbc.ca'),
(21, 'Eryn Corderoy', 'ecorderoyk@4shared.com'),
(22, 'Nikki Mildmott', 'nmildmottl@google.nl'),
(23, 'Constancia Kuschek', 'ckuschekm@blogs.com'),
(24, 'Camila Blasik', 'cblasikn@oracle.com'),
(25, 'Nolan Town', 'ntowno@mashable.com'),
(26, 'Neysa Rulf', 'nrulfp@slideshare.net'),
(27, 'Wendy Robertacci', 'wrobertacciq@clickbank.net'),
(28, 'Marris Laverty', 'mlavertyr@myspace.com'),
(29, 'Carolina Gaunter', 'cgaunters@free.fr'),
(30, 'Leonard Salmond', 'lsalmondt@oakley.com'),
(31, 'Marj Dimmick', 'mdimmicku@boston.com'),
(32, 'Ardisj Coombs', 'acoombsv@networkadvertising.org'),
(33, 'Doro Baylis', 'dbaylisw@google.ca'),
(34, 'Garvy Nalder', 'gnalderx@census.gov'),
(35, 'Virgilio MacDowal', 'vmacdowaly@yahoo.co.jp'),
(36, 'Collin Jaquin', 'cjaquinz@nba.com'),
(37, 'Doll Yushin', 'dyushin10@myspace.com'),
(38, 'Colleen Aykroyd', 'caykroyd11@ebay.com'),
(39, 'Jared Haps', 'jhaps12@ibm.com'),
(40, 'Bendite Dehmel', 'bdehmel13@sogou.com');

INSERT INTO Advertiser (advertiser_id, advertiser_email, advertiser_name)
VALUES
(1, 'wrispine0@arizona.edu', 'Topicware'),
(2, 'awhitear1@t-online.de', 'Snaptags'),
(3, 'pmackegg2@toplist.cz', 'Skyndu'),
(4, 'gkinner3@dailymotion.com', 'Yodoo'),
(5, 'pmcquillan4@phpbb.com', 'Bubblebox'),
(6, 'lcramphorn5@sohu.com', 'Jaxnation'),
(7, 'bphaup6@vinaora.com', 'Topicware'),
(8, 'bolivelli7@nyu.edu', 'Layo'),
(9, 'tmaidment8@creativecommons.org', 'Shuffledrive'),
(10, 'thasely9@netscape.com', 'Photolist'),
(11, 'jreiska@amazon.co.uk', 'Flashset'),
(12, 'acranageb@com.com', 'Miboo'),
(13, 'ycaudrayc@statcounter.com', 'Photolist'),
(14, 'cjouhandeaud@mysql.com', 'Babbleblab'),
(15, 'cborelle@wikimedia.org', 'Zoozzy'),
(16, 'lmcparlinf@mail.ru', 'Flashspan'),
(17, 'gelfittg@livejournal.com', 'Mymm'),
(18, 'nrudderhamh@sbwire.com', 'Jaloo'),
(19, 'ccapehorni@bravesites.com', 'Blogtag'),
(20, 'mlaugharnej@cdbaby.com', 'Pixoboo'),
(21, 'ngiffordk@bravesites.com', 'Gigazoom'),
(22, 'dnowelll@telegraph.co.uk', 'Jetpulse'),
(23, 'apaulom@nytimes.com', 'Realmix'),
(24, 'fgeaneyn@ifeng.com', 'Meejo'),
(25, 'iroydono@smugmug.com', 'Kanoodle'),
(26, 'delkinp@cisco.com', 'Einti'),
(27, 'eferrilloq@angelfire.com', 'Skipfire'),
(28, 'ygoodinr@edublogs.org', 'Yodel'),
(29, 'tsottells@usatoday.com', 'Voomm'),
(30, 'gterrist@irs.gov', 'Gigashots'),
(31, 'slangcastleu@mail.ru', 'Kamba'),
(32, 'mchesterv@opensource.org', 'Aimbu'),
(33, 'bdaalw@npr.org', 'Edgepulse'),
(34, 'hcunniamx@networksolutions.com', 'Aibox'),
(35, 'cnajaray@vimeo.com', 'Edgetag'),
(36, 'sguwerz@phpbb.com', 'Demimbu'),
(37, 'gotierney10@loc.gov', 'Gabvine'),
(38, 'meakeley11@storify.com', 'Zoomlounge'),
(39, 'acummine12@soup.io', 'Gabcube'),
(40, 'wfields13@answers.com', 'Oyondu');


INSERT INTO Advertisement (advertisement_id, content, active_start_date, active_end_date, total_cost, advertiser_id)
VALUES
(1, 'The best choice for your needs', '2025-01-26', '2024-06-01', 123.4, 1),
(2, 'Innovating the future', '2024-08-08', '2025-02-15', 79.5, 2),
(3, 'Quality you can trust', '2024-07-07', '2024-06-14', 198.04, 3),
(4, 'Empowering success', '2024-07-31', '2025-01-05', 77.24, 4),
(5, 'Leading the industry', '2025-03-14', '2024-07-01', 185.14, 5),
(6, 'The best choice for your needs', '2024-12-16', '2024-10-30', 130.62, 6),
(7, 'Innovating the future', '2025-01-11', '2024-02-27', 75.62, 7),
(8, 'Quality you can trust', '2024-12-27', '2024-04-25', 131.74, 8),
(9, 'Empowering success', '2025-04-11', '2025-02-15', 101.48, 9),
(10, 'Leading the industry', '2024-07-22', '2024-06-01', 91.82, 10),
(11, 'The best choice for your needs', '2025-04-06', '2024-10-05', 104.07, 11),
(12, 'Innovating the future', '2024-08-18', '2024-12-03', 87.65, 12),
(13, 'Quality you can trust', '2024-07-05', '2024-10-05', 125.41, 13),
(14, 'Empowering success', '2025-04-10', '2024-04-19', 138.73, 14),
(15, 'Leading the industry', '2024-05-18', '2024-09-30', 110.9, 15),
(16, 'The best choice for your needs', '2025-03-08', '2024-11-03', 184.68, 16),
(17, 'Innovating the future', '2024-12-16', '2024-05-27', 186.36, 17),
(18, 'Quality you can trust', '2024-03-30', '2024-09-14', 192.5, 18),
(19, 'Empowering success', '2024-02-14', '2024-09-05', 136.29, 19),
(20, 'Leading the industry', '2024-04-18', '2024-10-31', 69.57, 20),
(21, 'The best choice for your needs', '2025-02-08', '2025-02-15', 174.5, 21),
(22, 'Innovating the future', '2024-06-25', '2024-10-24', 169.15, 22),
(23, 'Quality you can trust', '2024-12-23', '2024-05-10', 76.56, 23),
(24, 'Empowering success', '2024-11-19', '2024-11-15', 186.46, 24),
(25, 'Leading the industry', '2025-01-04', '2025-01-12', 188.23, 25),
(26, 'The best choice for your needs', '2025-03-08', '2024-02-20', 198.75, 26),
(27, 'Innovating the future', '2024-06-05', '2025-02-28', 86.21, 27),
(28, 'Quality you can trust', '2024-03-26', '2024-04-10', 92.83, 28),
(29, 'Empowering success', '2024-08-08', '2024-08-15', 152.77, 29),
(30, 'Leading the industry', '2024-03-04', '2024-05-18', 176.16, 30),
(31, 'The best choice for your needs', '2025-03-14', '2024-07-10', 139.2, 31),
(32, 'Innovating the future', '2024-12-19', '2024-09-23', 135.59, 32),
(33, 'Quality you can trust', '2025-03-29', '2025-02-21', 118.0, 33),
(34, 'Empowering success', '2025-03-31', '2024-07-07', 111.44, 34),
(35, 'Leading the industry', '2024-03-16', '2024-06-24', 167.0, 35),
(36, 'The best choice for your needs', '2025-01-19', '2024-07-15', 190.04, 36),
(37, 'Innovating the future', '2024-09-06', '2024-12-25', 159.44, 37),
(38, 'Quality you can trust', '2024-11-25', '2024-04-30', 132.4, 38),
(39, 'Empowering success', '2024-02-21', '2024-05-17', 61.66, 39),
(40, 'Leading the industry', '2024-09-03', '2024-05-05', 173.57, 40);


INSERT INTO Ad_Space (ad_space_id, cost, advertisement_id)
VALUES
(1, 125.07, 5096),
(2, 118.76, 4747),
(3, 130.51, 6002),
(4, 130.43, 9787),
(5, 51.78, 4357),
(6, 163.01, 5318),
(7, 128.47, 6466),
(8, 166.0, 2587),
(9, 111.87, 4122),
(10, 75.12, 5088),
(11, 173.98, 8617),
(12, 158.97, 6366),
(13, 189.8, 5103),
(14, 161.32, 7764),
(15, 186.45, 5072),
(16, 154.05, 8081),
(17, 170.83, 4702),
(18, 125.87, 4797),
(19, 66.29, 9870),
(20, 134.26, 8312),
(21, 145.53, 5214),
(22, 133.04, 1860),
(23, 138.72, 1575),
(24, 120.52, 8294),
(25, 123.74, 1366),
(26, 186.96, 5412),
(27, 119.08, 5802),
(28, 112.72, 2123),
(29, 79.21, 9329),
(30, 60.6, 4649),
(31, 137.97, 8047),
(32, 76.68, 5836),
(33, 183.96, 9536),
(34, 164.11, 2278),
(35, 76.72, 9941),
(36, 83.88, 5676),
(37, 83.03, 7209),
(38, 146.93, 5777),
(39, 193.73, 5976),
(40, 148.07, 5963);


INSERT INTO UserFollows (follower_id, following_id)
VALUES
(4526, 9036),
(9036, 9168),
(9168, 7097),
(7097, 5604),
(5604, 9909),
(9909, 5971),
(5971, 8858),
(8858, 8256),
(8256, 4740),
(4740, 2006),
(2006, 2101),
(2101, 5526),
(5526, 9064),
(9064, 7326),
(7326, 9822),
(9822, 7722),
(7722, 5147),
(5147, 3122),
(3122, 1224),
(1224, 8946),
(8946, 4504),
(4504, 4954),
(4954, 9091),
(9091, 2304),
(2304, 6384),
(6384, 8106),
(8106, 9443),
(9443, 3934),
(3934, 6657),
(6657, 6157);


INSERT INTO Restaurant_Tags(restaurant_id, tag_id)
VALUES
(7768, 1),
(6242, 2),
(3305, 3),
(1830, 4),
(3107, 5),
(5745, 6),
(3424, 7),
(3314, 8),
(7104, 9),
(3189, 10),
(2381, 11),
(4489, 12),
(4825, 13),
(3746, 14),
(5802, 15),
(8544, 16),
(4591, 17),
(2102, 18),
(9979, 19),
(9979, 20),
(4876, 21),
(7428, 22),
(4472, 23),
(2056, 24),
(5054, 25),
(5099, 26),
(2101, 27),
(4860, 28),
(3608, 29),
(6293, 30),
(8583, 31),
(1526, 32),
(2194, 33),
(1234, 34),
(9734, 35),
(2304, 36),
(5576, 37),
(5647, 38),
(8372, 39),
(7768, 40);


INSERT INTO User_Favorites (user_id, restaurant_id)
VALUES
(4526, 7768),
(9036, 6242),
(9168, 3305),
(7097, 1830),
(5604, 3107),
(9909, 5745),
(5971, 3424),
(8858, 3314),
(8256, 7104),
(4740, 3189),
(2006, 2381),
(2101, 4489),
(5526, 4825),
(9064, 3746),
(7326, 5802),
(9822, 8544),
(7722, 4591),
(5147, 2102),
(3122, 9979),
(1224, 9979),
(8946, 4876),
(4504, 7428),
(4954, 4472),
(9091, 2056),
(2304, 5054),
(6384, 5099),
(8106, 2101),
(9443, 4860),
(3934, 3608),
(6657, 6293),
(6157, 8583),
(9849, 1526),
(4695, 2194),
(3116, 1234),
(2422, 9734),
(2129, 2304),
(9771, 5576),
(1417, 5647),
(5923, 8372),
(4680, 7768);


INSERT INTO Reported_Comments (user_id, comment_id)
VALUES
(4504, 1),
(2304, 2),
(2101, 3),
(8106, 4),
(2422, 5),
(7722, 6),
(4504, 7),
(4740, 8),
(3116, 9),
(4526, 10),
(1417, 11),
(5604, 12),
(4504, 13),
(2101, 14),
(5526, 15),
(2101, 16),
(4954, 17),
(3122, 18),
(2006, 19),
(4526, 20);


INSERT INTO Reported_Reviews (user_id, review_id)
VALUES
(8256, 1),
(4680, 2),
(2006, 3),
(9849, 4),
(8858, 5),
(4740, 6),
(8106, 7),
(7326, 8),
(2422, 9),
(2129, 10),
(3934, 11),
(9036, 12),
(5147, 13),
(2304, 14),
(7722, 15),
(7097, 16),
(8858, 17),
(8106, 18),
(5923, 19),
(5147, 20);






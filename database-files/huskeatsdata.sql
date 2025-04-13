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
((1, 'Kara-lynn', 'Kuhnwald', 'kkuhnwald0@eepurl.com', '2024-04-25', 0),
(2, 'Barny', 'Spavins', 'bspavins1@newyorker.com', '2024-09-25', 1),
(3, 'Madlin', 'Neeve', 'mneeve2@jigsy.com', '2024-08-05', 1),
(4, 'Giacomo', 'De Biaggi', 'gdebiaggi3@flickr.com', '2025-03-09', 0),
(5, 'Aggi', 'Ashington', 'aashington4@jiathis.com', '2024-06-20', 0),
(6, 'Cortie', 'Berggren', 'cberggren5@samsung.com', '2025-02-20', 0),
(7, 'Ingrim', 'Stenson', 'istenson6@home.pl', '2024-12-15', 1),
(8, 'Edik', 'Bute', 'ebute7@ucoz.com', '2024-10-29', 0),
(9, 'Ivy', 'Jarmyn', 'ijarmyn8@apple.com', '2025-03-27', 1),
(10, 'Jermain', 'Plowes', 'jplowes9@google.com.br', '2024-06-26', 1),
(11, 'Luis', 'Purdon', 'lpurdona@ucoz.ru', '2024-12-28', 0),
(12, 'Ragnar', 'Fishburn', 'rfishburnb@unblog.fr', '2024-08-06', 1),
(13, 'Fernando', 'Overnell', 'fovernellc@acquirethisname.com', '2024-11-21', 0),
(14, 'Candice', 'Ivanishev', 'civanishevd@timesonline.co.uk', '2024-07-02', 1),
(15, 'Gabriella', 'Moisey', 'gmoiseye@marriott.com', '2024-05-06', 1),
(16, 'Celestina', 'Watters', 'cwattersf@dell.com', '2025-04-01', 0),
(17, 'Moishe', 'Butteris', 'mbutterisg@naver.com', '2025-04-08', 1),
(18, 'Albie', 'Spurling', 'aspurlingh@admin.ch', '2024-09-26', 1),
(19, 'Hagen', 'Kempster', 'hkempsteri@github.io', '2024-05-08', 0),
(20, 'Raleigh', 'Bruckner', 'rbrucknerj@japanpost.jp', '2024-11-13', 0),
(21, 'Jarrid', 'Szymonowicz', 'jszymonowiczk@cbslocal.com', '2024-07-21', 1),
(22, 'Tyrone', 'Stainbridge', 'tstainbridgel@loc.gov', '2024-06-14', 0),
(23, 'Neill', 'Billborough', 'nbillboroughm@live.com', '2024-08-29', 1),
(24, 'Kip', 'Pierpoint', 'kpierpointn@youtu.be', '2024-09-17', 1),
(25, 'Phillip', 'Merdew', 'pmerdewo@sbwire.com', '2024-12-09', 0),
(26, 'Margeaux', 'Kloss', 'mklossp@fda.gov', '2024-08-27', 1),
(27, 'Paolina', 'Cristofari', 'pcristofariq@shareasale.com', '2024-05-15', 1),
(28, 'Lotti', 'Verissimo', 'lverissimor@mtv.com', '2025-03-19', 0),
(29, 'Tatiania', 'Castille', 'tcastilles@scientificamerican.com', '2024-09-05', 1),
(30, 'Mile', 'Tregaskis', 'mtregaskist@timesonline.co.uk', '2024-09-12', 1),
(31, 'Carin', 'Crippill', 'ccrippillu@google.ru', '2024-11-06', 1),
(32, 'Garry', 'Paxeford', 'gpaxefordv@plala.or.jp', '2024-10-11', 0),
(33, 'Rickie', 'Ormerod', 'rormerodw@freewebs.com', '2024-08-25', 0),
(34, 'Hart', 'Cockhill', 'hcockhillx@360.cn', '2025-03-01', 0),
(35, 'Diana', 'Ainger', 'daingery@google.ca', '2024-08-22', 1),
(36, 'Meggy', 'MacAnellye', 'mmacanellyez@amazon.co.jp', '2024-08-08', 0),
(37, 'Kristan', 'Balaam', 'kbalaam10@home.pl', '2024-11-14', 1),
(38, 'Alyssa', 'Joncic', 'ajoncic11@ihg.com', '2024-05-16', 0),
(39, 'Meade', 'MacAlester', 'mmacalester12@washingtonpost.com', '2024-10-17', 0),
(40, 'Charlie', 'Newarte', 'cnewarte13@edublogs.org', '2025-01-12', 0),
(41, 'Jordain', 'Swainson', 'jswainson14@soup.io', '2024-09-27', 0),
(42, 'Tatiania', 'Trill', 'ttrill15@npr.org', '2024-04-15', 0),
(43, 'Lynett', 'Swanger', 'lswanger16@g.co', '2024-12-11', 1),
(44, 'Brooke', 'Scamaden', 'bscamaden17@census.gov', '2025-01-25', 0),
(45, 'Fanchette', 'Trew', 'ftrew18@statcounter.com', '2024-06-16', 0),
(46, 'Carola', 'Feragh', 'cferagh19@angelfire.com', '2024-10-25', 1),
(47, 'Cly', 'Markovic', 'cmarkovic1a@shinystat.com', '2024-07-13', 1),
(48, 'Tricia', 'Paramor', 'tparamor1b@bandcamp.com', '2024-08-12', 0),
(49, 'Dougy', 'Bloyes', 'dbloyes1c@apple.com', '2024-10-19', 1),
(50, 'Wylie', 'Ponting', 'wponting1d@fotki.com', '2024-10-21', 0);)




INSERT INTO Restaurant_Profile(restaurant_id, name, address, image, description, promotional_image, menu_image, hours, approval_status)
VALUES
((1, 'The Hungry Hippo', '0 Dwight Trail', NULL, 'ante ipsum primis in faucibus orci luctus', NULL, NULL, '7:10 PM', 0),
(2, 'Sizzling Sausage Shack', '01 Hoard Terrace', NULL, 'posuere cubilia curae donec pharetra magna vestibulum aliquet', NULL, NULL, '10:54 PM', 1),
(3, 'Cheesy Delight', '8 Service Place', NULL, 'felis ut at dolor quis', NULL, NULL, '11:36 PM', 0),
(4, 'Burger Barn', '68 Duke Hill', NULL, 'id turpis integer aliquet massa id lobortis convallis', NULL, NULL, '10:27 PM', 1),
(5, 'Pasta Paradise', '3 Shelley Point', NULL, 'ridiculus mus etiam vel augue vestibulum', NULL, NULL, '6:50 PM', 0),
(6, 'Taco Town', '14 Burning Wood Center', NULL, 'hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer', NULL, NULL, '7:23 PM', 1),
(7, 'Pizza Palace', '436 Hallows Road', NULL, 'elementum pellentesque quisque porta volutpat', NULL, NULL, '7:15 PM', 1),
(8, 'Waffle World', '0 Lakeland Hill', NULL, 'quam sapien varius ut blandit', NULL, NULL, '8:35 PM', 1),
(9, 'Sushi Spot', '33 Forster Circle', NULL, 'sagittis dui vel nisl duis ac nibh fusce lacus purus', NULL, NULL, '11:20 PM', 0),
(10, 'BBQ Bonanza', '3842 Fisk Crossing', NULL, 'suscipit nulla elit ac nulla sed vel enim sit', NULL, NULL, '7:06 PM', 1),
(11, 'Noodle Nook', '103 Daystar Park', NULL, 'amet nulla quisque arcu libero rutrum ac lobortis vel', NULL, NULL, '11:02 PM', 0),
(12, 'Burrito Bliss', '330 Debs Center', NULL, 'varius integer ac leo pellentesque ultrices mattis odio donec vitae', NULL, NULL, '9:56 PM', 1),
(13, 'Salad Sensation', '387 Dwight Trail', NULL, 'volutpat erat quisque erat eros viverra eget congue eget', NULL, NULL, '11:32 PM', 0),
(14, 'Wrap City', '59716 Onsgard Junction', NULL, 'volutpat erat quisque erat eros viverra eget congue eget semper', NULL, NULL, '6:54 PM', 0),
(15, 'Fried Chicken Factory', '984 Maple Place', NULL, 'nisl venenatis lacinia aenean sit amet justo morbi', NULL, NULL, '7:30 PM', 0),
(16, 'Smoothie Station', '5 School Avenue', NULL, 'est donec odio justo sollicitudin ut suscipit a feugiat', NULL, NULL, '6:31 PM', 1),
(17, 'Diner Delight', '643 Orin Court', NULL, 'amet consectetuer adipiscing elit proin interdum mauris', NULL, NULL, '11:58 PM', 0),
(18, 'Coffee Corner', '4 Grayhawk Hill', NULL, 'mauris morbi non lectus aliquam sit', NULL, NULL, '9:18 PM', 0),
(19, 'Ice Cream Island', '441 Tennessee Circle', NULL, 'in tempor turpis nec euismod scelerisque quam turpis adipiscing', NULL, NULL, '7:41 PM', 1),
(20, 'Donut Den', '77 Harbort Point', NULL, 'in faucibus orci luctus et ultrices posuere cubilia curae duis', NULL, NULL, '10:18 PM', 1),
(21, 'Bagel Boutique', '8991 Alpine Alley', NULL, 'risus semper porta volutpat quam pede lobortis ligula', NULL, NULL, '9:19 PM', 0),
(22, 'Crepes Cafe', '8361 Sundown Lane', NULL, 'purus eu magna vulputate luctus', NULL, NULL, '10:25 PM', 1),
(23, 'Hot Dog Haven', '14 Emmet Drive', NULL, 'id sapien in sapien iaculis', NULL, NULL, '7:56 PM', 1),
(24, 'Sandwich Shoppe', '55 Forest Dale Parkway', NULL, 'vel augue vestibulum ante ipsum primis in faucibus orci luctus', NULL, NULL, '8:05 PM', 1),
(25, 'Soup Stop', '1 Hermina Circle', NULL, 'consectetuer adipiscing elit proin risus', NULL, NULL, '11:38 PM', 0),
(26, 'Fish Fry', '3435 Beilfuss Place', NULL, 'lacinia aenean sit amet justo morbi ut odio cras mi', NULL, NULL, '9:28 PM', 0),
(27, 'Pancake Place', '698 Vidon Road', NULL, 'sed interdum venenatis turpis enim blandit', NULL, NULL, '7:02 PM', 0),
(28, 'Bakery Bliss', '4 Northridge Plaza', NULL, 'molestie lorem quisque ut erat curabitur gravida nisi at', NULL, NULL, '11:11 PM', 0),
(29, 'Juice Joint', '6451 Marcy Avenue', NULL, 'blandit non interdum in ante vestibulum ante', NULL, NULL, '8:14 PM', 0),
(30, 'Grill House', '6872 Eastlawn Circle', NULL, 'proin eu mi nulla ac enim in tempor turpis nec', NULL, NULL, '11:03 PM', 0),
(31, 'Subway Stop', '04 Nova Pass', NULL, 'ultrices phasellus id sapien in sapien iaculis congue vivamus', NULL, NULL, '6:21 PM', 0),
(32, 'Milkshake Mansion', '1185 Sachtjen Court', NULL, 'neque duis bibendum morbi non quam nec dui luctus rutrum', NULL, NULL, '11:39 PM', 0),
(33, 'Taco Truck', '6893 Parkside Alley', NULL, 'quis augue luctus tincidunt nulla', NULL, NULL, '8:13 PM', 0),
(34, 'Pita Pit', '1994 Dakota Alley', NULL, 'libero nam dui proin leo odio porttitor id consequat in', NULL, NULL, '6:37 PM', 1),
(35, 'Ramen Retreat', '936 Union Drive', NULL, 'semper porta volutpat quam pede', NULL, NULL, '11:33 PM', 0),
(36, 'Pho Phactory', '276 David Place', NULL, 'in blandit ultrices enim lorem ipsum', NULL, NULL, '6:24 PM', 1),
(37, 'Falafel Fiesta', '4 Waywood Place', NULL, 'platea dictumst morbi vestibulum velit id pretium', NULL, NULL, '8:22 PM', 1),
(38, 'Bistro Bites', '58271 Johnson Crossing', NULL, 'aliquet at feugiat non pretium quis lectus suspendisse potenti in', NULL, NULL, '11:11 PM', 1),
(39, 'Cafe Crema', '63 Brickson Park Junction', NULL, 'a libero nam dui proin leo odio porttitor', NULL, NULL, '10:07 PM', 1),
(40, 'The Hungry Hippo', '6144 Badeau Plaza', NULL, 'justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis', NULL, NULL, '9:54 PM', 0);)


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
((1, 31, 17, 'ac tellus semper', 4, 'leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac', NULL),
(2, 15, 11, 'sit amet justo morbi ut odio cras mi pede', 2, 'cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing', NULL),
(3, 31, 33, 'nibh ligula nec sem duis', 2, 'nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel', NULL),
(4, 4, 16, 'potenti cras in purus eu magna', 1, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia', NULL),
(5, 2, 17, 'vestibulum eget vulputate', 2, 'eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse', NULL),
(6, 26, 7, 'et tempus semper est quam pharetra magna ac consequat', 5, 'tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus', NULL),
(7, 30, 17, 'rhoncus dui vel sem', 3, 'elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi', NULL),
(8, 29, 23, 'sed vestibulum sit amet cursus id turpis integer', 2, 'penatibus et magnis dis parturient montes nascetur ridiculus mus', NULL),
(9, 22, 23, 'scelerisque mauris sit amet eros suspendisse accumsan', 1, 'morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer', NULL),
(10, 40, 37, 'lectus aliquam sit amet diam in', 4, 'odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque', NULL),
(11, 1, 1, 'aliquet at feugiat non pretium quis lectus suspendisse potenti', 4, 'vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur', NULL),
(12, 28, 34, 'ante vel ipsum', 3, 'habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque', NULL),
(13, 37, 39, 'etiam faucibus cursus urna', 3, 'tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo', NULL),
(14, 4, 38, 'penatibus et magnis dis parturient montes nascetur', 4, 'aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo', NULL),
(15, 48, 33, 'congue vivamus metus arcu adipiscing', 1, 'suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris', NULL),
(16, 7, 33, 'maecenas rhoncus aliquam lacus morbi quis', 3, 'hac habitasse platea dictumst maecenas', NULL),
(17, 17, 7, 'dapibus duis at velit eu est congue', 3, 'ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti', NULL),
(18, 5, 4, 'at vulputate vitae nisl aenean', 5, 'quis augue luctus tincidunt nulla mollis molestie lorem quisque', NULL),
(19, 3, 34, 'ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit', 2, 'etiam faucibus cursus urna ut tellus nulla ut erat id', NULL),
(20, 25, 31, 'aenean lectus pellentesque eget nunc', 3, 'id nisl venenatis lacinia aenean sit amet justo', NULL),
(21, 41, 20, 'vitae nisl aenean lectus', 3, 'nonummy maecenas tincidunt lacus at velit', NULL),
(22, 32, 3, 'quam nec dui luctus rutrum nulla tellus in sagittis dui', 2, 'sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla', NULL),
(23, 20, 29, 'semper porta volutpat quam pede lobortis', 2, 'metus vitae ipsum aliquam non', NULL),
(24, 9, 11, 'vestibulum sagittis sapien cum sociis natoque', 5, 'mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce', NULL),
(25, 32, 33, 'felis fusce posuere', 5, 'sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus', NULL),
(26, 49, 11, 'proin interdum mauris non ligula pellentesque ultrices', 3, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac', NULL),
(27, 42, 34, 'pede lobortis ligula sit amet eleifend pede libero', 4, 'posuere cubilia curae nulla dapibus dolor vel est donec odio justo', NULL),
(28, 43, 28, 'posuere cubilia curae nulla', 5, 'luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea', NULL),
(29, 39, 27, 'mi integer ac neque duis bibendum morbi non', 1, 'et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum', NULL),
(30, 46, 10, 'mus vivamus vestibulum sagittis sapien', 2, 'ut nunc vestibulum ante ipsum primis in faucibus orci luctus', NULL),
(31, 21, 15, 'sed lacus morbi sem mauris laoreet ut rhoncus aliquet', 5, 'quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum', NULL),
(32, 34, 5, 'convallis duis consequat', 3, 'justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id', NULL),
(33, 44, 20, 'primis in faucibus orci luctus et ultrices posuere cubilia', 3, 'in ante vestibulum ante ipsum', NULL),
(34, 30, 1, 'eget tempus vel pede morbi porttitor lorem', 4, 'pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec', NULL),
(35, 41, 27, 'blandit mi in porttitor pede justo eu massa', 4, 'id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat', NULL),
(36, 20, 14, 'rutrum neque aenean auctor gravida sem praesent id', 3, 'justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus', NULL),
(37, 33, 25, 'nullam porttitor lacus at turpis donec posuere metus vitae ipsum', 3, 'fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales', NULL),
(38, 15, 34, 'volutpat eleifend donec', 1, 'nisi volutpat eleifend donec ut dolor morbi', NULL),
(39, 4, 11, 'ipsum primis in', 5, 'at nibh in hac habitasse', NULL),
(40, 38, 23, 'luctus tincidunt nulla mollis', 2, 'sodales sed tincidunt eu felis fusce posuere', NULL);)


INSERT INTO Comment (comment_id, content, review_id, user_id)
VALUES
((1, 'id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci', 31, 13),
(2, 'morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris', 10, 10),
(3, 'magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id', 37, 30),
(4, 'sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris', 15, 26),
(5, 'blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum', 20, 25),
(6, 'mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis', 39, 15),
(7, 'id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu', 30, 48),
(8, 'in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis', 9, 2),
(9, 'in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius', 39, 11),
(10, 'montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue', 31, 19),
(11, 'habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis', 37, 35),
(12, 'libero quis orci nullam molestie nibh in lectus pellentesque at nulla', 30, 7),
(13, 'sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras', 18, 28),
(14, 'ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla', 3, 16),
(15, 'in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl', 31, 4),
(16, 'lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere', 19, 19),
(17, 'accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet', 16, 31),
(18, 'ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend', 19, 10),
(19, 'elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum', 10, 6),
(20, 'vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum', 15, 15),
(21, 'ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla', 18, 3),
(22, 'a suscipit nulla elit ac nulla sed vel enim sit amet', 1, 23),
(23, 'luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce', 21, 50),
(24, 'orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non', 20, 47),
(25, 'quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam', 16, 28),
(26, 'tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis', 10, 26),
(27, 'donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis', 22, 47),
(28, 'ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue', 29, 26),
(29, 'vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia', 23, 21),
(30, 'pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras', 16, 3),
(31, 'id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla', 31, 32),
(32, 'pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at', 17, 49),
(33, 'lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus', 22, 45),
(34, 'lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum', 2, 35),
(35, 'leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas', 14, 3),
(36, 'in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur', 16, 44),
(37, 'duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh', 20, 5),
(38, 'fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio', 11, 18),
(39, 'placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus', 6, 1),
(40, 'pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut', 10, 45);)



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
((21, 49),
(40, 19),
(45, 13),
(4, 6),
(11, 40),
(48, 26),
(39, 48),
(26, 2),
(32, 9),
(16, 25),
(24, 47),
(49, 21),
(46, 37),
(18, 13),
(30, 14),
(14, 20),
(31, 9),
(15, 40),
(26, 11),
(44, 23),
(30, 24),
(34, 33),
(47, 5),
(32, 6),
(33, 24),
(38, 43),
(39, 48),
(50, 23),
(32, 29),
(1, 4),
(39, 12),
(37, 9),
(30, 26),
(24, 22),
(32, 50),
(15, 47),
(37, 38),
(41, 47),
(37, 11),
(41, 48);)


INSERT INTO Restaurant_Tags(restaurant_id, tag_id)
VALUES
((5, 28),
(35, 18),
(7, 16),
(5, 34),
(12, 24),
(15, 39),
(19, 3),
(28, 26),
(11, 6),
(38, 10),
(26, 21),
(30, 1),
(28, 2),
(5, 14),
(26, 15),
(39, 38),
(33, 25),
(10, 21),
(10, 30),
(12, 6),
(36, 39),
(12, 23),
(36, 16),
(24, 34),
(1, 13),
(24, 10),
(34, 34),
(25, 32),
(31, 18),
(5, 13),
(8, 13),
(40, 31),
(28, 20),
(21, 28),
(35, 37),
(1, 16),
(30, 8),
(15, 32),
(14, 18),
(24, 22);)



INSERT INTO User_Favorites (restaurant_id, user_id)
VALUES
((5, 1),
(2, 23),
(30, 45),
(24, 19),
(8, 24),
(14, 6),
(4, 31),
(11, 14),
(33, 14),
(37, 9),
(10, 12),
(9, 3),
(33, 50),
(6, 4),
(14, 41),
(5, 32),
(13, 49),
(4, 49),
(9, 2),
(22, 4),
(32, 8),
(33, 16),
(8, 35),
(17, 18),
(4, 18),
(5, 45),
(18, 13),
(24, 20),
(21, 21),
(8, 24),
(17, 37),
(23, 8),
(37, 32),
(37, 42),
(3, 28),
(4, 50),
(39, 14),
(21, 14),
(9, 10),
(37, 19);)



INSERT INTO Reported_Comments (user_id, comment_id)
VALUES
((11, 38),
(15, 9),
(33, 12),
(45, 6),
(40, 19),
(16, 31),
(41, 6),
(38, 2),
(20, 8),
(33, 12),
(45, 10),
(47, 14),
(5, 11),
(47, 6),
(45, 39),
(11, 16),
(29, 7),
(35, 32),
(2, 39),
(29, 38);)


INSERT INTO Reported_Reviews (user_id, review_id)
VALUES
((50, 37),
(45, 7),
(37, 30),
(35, 5),
(44, 13),
(2, 39),
(47, 2),
(30, 26),
(9, 11),
(45, 9),
(37, 22),
(37, 13),
(1, 7),
(24, 12),
(46, 23),
(15, 10),
(31, 21),
(25, 25),
(17, 13),
(34, 24);)






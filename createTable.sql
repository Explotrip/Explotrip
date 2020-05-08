DROP TABLE IF EXISTS assignement_image;
DROP TABLE IF EXISTS assignement_extra;
-- DROP TABLE IF EXISTS assignement_localisation;
-- DROP TABLE IF EXISTS assignement_type;
-- DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS research_stats;
DROP TABLE IF EXISTS click_stats;
DROP TABLE IF EXISTS favorites;

DROP TABLE IF EXISTS travel_slot;
DROP TABLE IF EXISTS travel;

DROP TABLE IF EXISTS travel_type;
DROP TABLE IF EXISTS extra;
DROP TABLE IF EXISTS image;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS region;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS language;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS newsletter;


create table newsletter (
    id_newsletter int NOT NULL AUTO_INCREMENT, 
    lastname varchar(30) NOT NULL, 
    firstname varchar(30) NOT NULL, 
    email varchar(50) NOT NULL,
    primary key (id_newsletter)
);

create table users (
    id_users int NOT NULL AUTO_INCREMENT, 
    lastname varchar(30) NOT NULL, 
    firstname varchar(30) NOT NULL, 
    email varchar(50) NOT NULL,
    phone varchar(20),
    password varchar(500) NOT NULL,
    primary key (id_users)
);

create table language (
  id_language int NOT NULL AUTO_INCREMENT, 
  language VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_language)
);

create table country (
  id_country int NOT NULL AUTO_INCREMENT, 
  country VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_country)
);

create table region (
  id_region int NOT NULL AUTO_INCREMENT, 
  id_country int NOT NULL, 
  region VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_region),
  foreign key (id_country) references country (id_country)
);

create table city (
  id_city int NOT NULL AUTO_INCREMENT, 
  id_region int NOT NULL, 
  id_country int NOT NULL, 
  city VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_city),
  foreign key (id_country) references country (id_country),
  foreign key (id_region) references region (id_region)
);

create table image (
  id_image int NOT NULL AUTO_INCREMENT, 
  path VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_image)
);

create table extra (
  id_extra int NOT NULL AUTO_INCREMENT, 
  name VARCHAR(100) NOT NULL,
  description VARCHAR(500) NOT NULL,
  price int NOT NULL,
  PRIMARY KEY (id_extra)
);

create table travel_type (
  id_travel_type int NOT NULL AUTO_INCREMENT, 
  title VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_travel_type)
);

create table travel (
  id_travel int NOT NULL AUTO_INCREMENT, 
  id_company int, -- Foreign Key
  id_main_image int NOT NULL,
  id_language int NOT NULL,
  id_country int NOT NULL,
  id_region int,
  id_city int,
  id_travel_type int NOT NULL,
  title VARCHAR(100) NOT NULL,
  description VARCHAR(10000) NOT NULL,
  age_minimum int NOT NULL,
  age_maximum int NOT NULL,
  PRIMARY KEY (id_travel),
  -- foreign key (id_company) references company (id_company),
  foreign key (id_language) references language (id_language),
  foreign key (id_country) references country (id_country),
  foreign key (id_region) references region (id_region),
  foreign key (id_city) references city (id_city),
  foreign key (id_travel_type) references travel_type (id_travel_type)
);

create table travel_slot (
  id_slot int NOT NULL AUTO_INCREMENT, 
  id_travel int NOT NULL,
  slot ENUM( 'byDate', 'byDuration') NOT NULL,
  slot_from date NOT NULL,
  slot_to date,
  days_duration int,
  price int NOT NULL,
  nb_place int NOT NULL,
  PRIMARY KEY (id_slot),
  foreign key (id_travel) references travel (id_travel)
);

create table favorites (
  id_favorite int NOT NULL AUTO_INCREMENT, 
  id_travel int NOT NULL,
  id_users int NOT NULL,
  fav_state ENUM( 'is', 'hasBeen') NOT NULL,
  fav_from date NOT NULL,
  fav_to date,
  PRIMARY KEY (id_favorite),
  foreign key (id_travel) references travel (id_travel),
  foreign key (id_users) references users (id_users)
);

create table click_stats (
  id_click_stats int NOT NULL AUTO_INCREMENT, 
  id_travel int NOT NULL,
  id_users int NOT NULL,
  click_date date NOT NULL,
  click_time time NOT NULL,
  PRIMARY KEY (id_click_stats),
  foreign key (id_travel) references travel (id_travel),
  foreign key (id_users) references users (id_users)
);

create table research_stats (
  id_research_stats int NOT NULL AUTO_INCREMENT, 
  id_users int NOT NULL,
  id_language int NOT NULL,
  id_country int,
  age int,
  research_date date NOT NULL,
  research_time time NOT NULL,
  PRIMARY KEY (id_research_stats),
  foreign key (id_users) references users (id_users),
  foreign key (id_language) references language (id_language),
  foreign key (id_country) references country (id_country)
);

-- create table reviews (
--   id_reviews int NOT NULL AUTO_INCREMENT, 
--   id_users int NOT NULL,
--   reviews_date date NOT NULL,
--   reviews_time time NOT NULL,
--   PRIMARY KEY (id_reviews),
--   foreign key (id_users) references users (id_users)
-- );

create table assignement_image (
  id_image int NOT NULL, 
  id_travel int NOT NULL,
  PRIMARY KEY (id_image,id_travel),
  foreign key (id_travel) references travel (id_travel),
  foreign key (id_image) references image (id_image)
);

create table assignement_extra (
  id_extra int NOT NULL, 
  id_travel int NOT NULL,
  PRIMARY KEY (id_extra,id_travel),
  foreign key (id_travel) references travel (id_travel),
  foreign key (id_extra) references extra (id_extra)
);



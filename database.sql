create database database_web;

use database_web;

create table brands(
    brand_id int not null auto_increment,
    name varchar(255) not null,
    description varchar(255) not null,
    primary key(brand_id)
);

create table product_types(
    type_id int not null auto_increment,
    product_type varchar(255) not null, -- de fata de ochi etc
    usage_time enum('zi','seara','oricand') not null,
    primary key(type_id)
);

create table skintypes(
    skintype_id int not null auto_increment,
    skin_type varchar(255) not null, -- uscat gras etc
    primary key (skintype_id)
);

create table users(
    user_id int not null auto_increment,
    name varchar(255) not null,
    username varchar(255) not null,
    email varchar(255) not null,
    password varchar(255) not null,
    age int not null,
    skintype_id int not null,
    gender enum('m','f','n'),
    location varchar(255),
    creation_time timestamp default current_timestamp,
    primary key (user_id),
    unique (username),
    unique (email),
    foreign key (skintype_id) references skintypes(skintype_id)
);

create table products(
    product_id int not null auto_increment,
    name varchar(255) not null,
    price decimal(10,2) not null,
    image_path varchar(255),
    is_makeup bool,
    age int not null,
    brand_id int not null,
    skintype_id int not null,
    type_id int not null,
    primary key (product_id),
    foreign key (brand_id) references brands(brand_id),
    foreign key (skintype_id) references skintypes(skintype_id),
    foreign key (type_id) references product_types(type_id)
);

create table rankings(
    ranking_id int not null auto_increment,
    age_min int not null,
    age_max int not null,
    gender enum('m','f','n'),
    location varchar(255),
    type_id int not null,
    primary key (ranking_id),
    foreign key (type_id) references product_types(type_id)
);
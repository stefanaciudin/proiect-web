create table brands
(
    brand_id    int auto_increment
        primary key,
    name        varchar(255) not null,
    description varchar(255) not null
);

create table product_types
(
    type_id      int auto_increment
        primary key,
    product_type varchar(255)                    not null,
    usage_time   enum ('zi', 'seara', 'oricand') not null
);

create table rankings
(
    ranking_id int auto_increment
        primary key,
    age_min    int                  not null,
    age_max    int                  not null,
    gender     enum ('m', 'f', 'n') null,
    location   varchar(255)         null,
    type_id    int                  not null,
    constraint rankings_ibfk_1
        foreign key (type_id) references product_types (type_id)
);

create index type_id
    on rankings (type_id);

create table skintypes
(
    skintype_id int auto_increment
        primary key,
    skin_type   varchar(255) not null
);

create table products
(
    product_id  int auto_increment
        primary key,
    name        varchar(255)   not null,
    price       decimal(10, 2) not null,
    image_path  varchar(255)   null,
    is_makeup   tinyint(1)     null,
    age         int            not null,
    brand_id    int            not null,
    skintype_id int            not null,
    type_id     int            not null,
    constraint products_ibfk_1
        foreign key (brand_id) references brands (brand_id),
    constraint products_ibfk_2
        foreign key (skintype_id) references skintypes (skintype_id),
    constraint products_ibfk_3
        foreign key (type_id) references product_types (type_id)
);

create index brand_id
    on products (brand_id);

create index skintype_id
    on products (skintype_id);

create index type_id
    on products (type_id);

create table users
(
    user_id       int auto_increment
        primary key,
    name          varchar(255)                        not null,
    surname       varchar(255)                        not null,
    username      varchar(255)                        not null,
    email         varchar(255)                        not null,
    password      varchar(255)                        not null,
    age           int       default 18                not null,
    skintype_id   int       default 1                 not null,
    gender        enum ('m', 'f', 'n')                null,
    location      varchar(255)                        null,
    creation_time timestamp default CURRENT_TIMESTAMP not null,
    constraint email
        unique (email),
    constraint username
        unique (username),
    constraint users_ibfk_1
        foreign key (skintype_id) references skintypes (skintype_id)
);

create index skintype_id
    on users (skintype_id);


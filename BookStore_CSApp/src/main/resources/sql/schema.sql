DROP TABLE IF EXISTS userrole;
DROP TABLE IF EXISTS AppUser;

create table if not exists Appuser (
    id long generated always as identity,
    username varchar(50) NOT NULL,
    password varchar(50) NOT NULL,
    fullname varchar(50) NOT NULL,
    email varchar(50)NOT NULL,
    deliveryaddress varchar(255)NOT NULL,
    primary key (username)
    );
create table if not exists userrole (
    user_role_id int generated always as identity,
    username varchar(50) not null,
    role varchar(50) not null,
    primary key (user_role_id),
    foreign key (username) references APPUSER(username)
    );
CREATE TABLE if not exists Book (
                       book_id long AUTO_INCREMENT,
                       bookname VARCHAR(255) NOT NULL,
                       author VARCHAR(255) NOT NULL,
                       price DECIMAL(10, 2) NOT NULL,
                       description TEXT,
                       availability BOOLEAN,
                       quantity int NOT NULL,
                       primary key (book_id)
);
CREATE TABLE if not exists COVER_PHOTO(
    id Long AUTO_INCREMENT,
    content blob,
    content_type varchar(255),
    filename varchar(255),
    book_id LONG,
    primary key(id),
    FOREIGN KEY (book_id) REFERENCES Book (book_id)
);
CREATE TABLE IF NOT EXISTS comment (
                                       id LONG AUTO_INCREMENT,
                                       username VARCHAR(50),
                                       content TEXT,
                                       timestamp TIMESTAMP,
                                       book_id LONG,
                                       PRIMARY KEY (id),
                                       FOREIGN KEY (book_id) REFERENCES Book (book_id)
);
CREATE TABLE IF NOT EXISTS  orders (
                        id LONG generated always as identity,
                        username VARCHAR(50) NOT NULL,
                        total_price DECIMAL(10, 2) NOT NULL,
                        order_date_time varchar(255) NOT NULL,
                        primary key (id)
);

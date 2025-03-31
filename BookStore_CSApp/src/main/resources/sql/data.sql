    INSERT INTO Appuser (username, password, fullname, email, deliveryaddress)
VALUES ('keith', '{noop}keithpw', 'keithwong', 'keith@gmail.com', 'abc house');

INSERT INTO userrole (username, role)
VALUES ('keith', 'ROLE_USER');

INSERT INTO userrole (username, role)
VALUES ('keith', 'ROLE_ADMIN');

INSERT INTO Appuser (username, password, fullname, email, deliveryaddress)
VALUES ('john', '{noop}johnpw', 'johnking', 'john@gmail.com', 'xxx house');

INSERT INTO userrole (username, role)
VALUES ('john', 'ROLE_ADMIN');

INSERT INTO Appuser (username, password, fullname, email, deliveryaddress)
VALUES ('mary', '{noop}marypw', 'maryjane', 'mary@gmail.com', 'zzz house');

INSERT INTO userrole (username, role)
VALUES ('mary', 'ROLE_USER');

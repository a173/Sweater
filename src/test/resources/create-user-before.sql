delete from user_role;
delete from usr;

insert into usr(id, username, email, password, active) values
(1, 'admin', 'admin@admin', '$2a$08$2BbaJ4UpReDXVmtMKNDFMu47K2i5h6r5NTUcyyKsMCIZq6PR.Ah6a', true),
(2, '123', '123@123', '$2a$08$OgHCwQhGuzOhZAtVZiqtZOfb75Y.SbmOwiOZ2aTpHv4057nso/aou', true);

insert into user_role(user_id, roles) values
(1, 'ADMIN'), (1, 'USER'),
(2, 'USER');
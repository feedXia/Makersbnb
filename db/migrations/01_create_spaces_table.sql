CREATE TABLE spaces (
  id SERIAL PRIMARY KEY, 
  name VARCHAR(60), 
  description VARCHAR(240), 
  price INTEGER, 
  host_id SERIAL
);
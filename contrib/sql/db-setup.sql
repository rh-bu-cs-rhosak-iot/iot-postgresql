CREATE TABLE public.junction (
   id text NOT NULL PRIMARY KEY,
   name text NOT NULL,
   latitude real NOT NULL,
   longitude real NOT NULL
);
ALTER TABLE public.junction OWNER TO $POSTGRESQL_USER;

CREATE TABLE public.meter (
   id text NOT NULL PRIMARY KEY,
   address text NOT NULL,
   latitude real NOT NULL,
   longitude real NOT NULL
);
ALTER TABLE public.meter OWNER TO $POSTGRESQL_USER;

CREATE TABLE public.meter_update (
   id serial PRIMARY KEY,
   meter_id text NOT NULL references meter(id),
   timestamp TIMESTAMP NOT NULL,
   status_text text NOT NULL
);
ALTER TABLE public.meter_update OWNER TO $POSTGRESQL_USER;

CREATE TABLE public.junction_update (
   id serial PRIMARY KEY,
   junction_id text NOT NULL references junction(id),
   timestamp TIMESTAMP NOT NULL,
   count_ns int NOT NULL,
   count_ew int NOT NULL
);
ALTER TABLE public.junction_update OWNER TO $POSTGRESQL_USER;

COPY junction(id,name,latitude,longitude) FROM '$SQL_DIR/junction_info.csv' DELIMITER ',' CSV HEADER;
COPY meter(id,address,latitude,longitude) FROM '$SQL_DIR//meter_info.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE streets AS SELECT substring(address from '[0-9]+ (.*)') as name FROM meter GROUP BY name;
ALTER TABLE public.streets OWNER TO $POSTGRESQL_USER;

CREATE SCHEMA public;

REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO sdss;
GRANT CREATE ON SCHEMA public TO PUBLIC;

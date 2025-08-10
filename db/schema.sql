## I creat my table i used 

CREATE TABLE IF NOT EXISTS public.books
(
    book_id SERIAL PRIMARY KEY,
    title character varying(255) NOT NULL,
    author character varying(255),
    genre character varying(100),
    publication_year integer NOT NULL,
    isbn character varying(20),
    page_count integer,
    word_count integer,
    spice_level integer,
    is_adult_only boolean DEFAULT false
);

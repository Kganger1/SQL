## I created my tables I used 

CREATE TABLE public.books
(
    book_id SERIAL PRIMARY KEY,
    title character varying(255) NOT NULL,
    author character varying(255),
    genre character varying(100),
    publication_year integer NOT NULL,
    isbn character varying(20),
    page_count integer,
    word_count integer,
    spice_level integer CHECK (spice_level BETWEEN 0 AND 3),
    is_adult_only boolean NOT NULL DEFAULT false
);
CREATE UNIQUE INDEX IF NOT EXISTS ux_books_isbn
  ON public.books (isbn) WHERE isbn IS NOT NULL;

CREATE TABLE reading_log (
  log_id SERIAL PRIMARY KEY,
  book_id integer NOT NULL REFERENCES public.books(book_id) ON DELETE CASCADE,
  start_date DATE,
  end_date DATE,
  rating INT CHECK (rating BETWEEN 1 AND 5),
  review TEXT,
  CHECK (end_date IS NULL OR start_date IS NULL OR end_date >= start_date)
);

CREATE TABLE public.personal_list (
  list_id SERIAL PRIMARY KEY,
  book_id integer NOT NULL REFERENCES public.books(book_id) ON DELETE CASCADE,
  list_type varchar(10) NOT NULL CHECK (list_type IN ('WISH','TBR')),
  priority_level integer CHECK (priority_level BETWEEN 1 AND 5)
);

CREATE UNIQUE INDEX IF NOT EXISTS ux_personal_list_unique
  ON public.personal_list (list_type, book_id);



## start adding books
INSERT INTO public.books (title, author, genre, publication_year, spice_level)
VALUES
('The Night Circus','Erin Morgenstern','Fantasy',2011,1),
('Fourth Wing','Rebecca Yarros','Fantasy',2023,3);

## add to personal list    
INSERT INTO public.personal_list (book_id, list_type, priority_level)
VALUES (1,'WISH',5)


# add to reading log
insert into public.reading_log (book_id, rating, review)
values (2, 4, 'DRAGONS!');

## run a test pull
SELECT b.title, b.author, pl.list_type, rl.rating
FROM public.books b
LEFT JOIN public.personal_list pl USING (book_id)
LEFT JOIN public.reading_log rl
  ON rl.book_id = b.book_id
  AND rl.log_id = (
    SELECT log_id
    FROM public.reading_log
    WHERE book_id = b.book_id
    ORDER BY end_date DESC NULLS LAST, start_date DESC
    LIMIT 1
  )
ORDER BY b.title;


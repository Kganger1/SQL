

## HI!

## Welcome to my SQL Portfolio. Here you find examples of the SQL I have written. Feel free to look around at some of those examples, and if you have any questions, don't hesitate to reach out via LinkedIn with any questions:
www.linkedin.com/in/kiganger


# 📚 Book Nook DB

A PostgreSQL database project for tracking books, reading logs, ratings, and recommendations.  
Perfect for book lovers who want to keep a personal library and generate fun reading suggestions.

---

## 📖 Features
- Store book details (title, author, genre, year, pages, ISBN).
- Track reading logs with ratings and reviews.
- Maintain a wish list with priority levels.
- Generate random recommendations from your favorite genres.
- Easy to extend for BookTok, BookTube, or other book-tracking needs.

---

## 🗂️ Database Structure
**Tables:**
1. `books` – book details.
2. `readers` – people using the tracker.
3. `reading_log` – what’s been read, when, and the rating/review.
4. `wish_list` – books to read in the future.

---

## 🚀 Getting Started
### Requirements
- PostgreSQL 16+  

### Setup
1. Clone this repo or download it.
2. Run `schema.sql` to create tables.
3. Run `seed.sql` to insert sample data.
4. Explore using `queries.sql`.

---

## 🧠 Example Recommendation Query
```sql
SELECT b.title, b.author, b.genre
FROM books b
WHERE b.genre IN (
    SELECT genre
    FROM books
    JOIN reading_log USING (book_id)
    WHERE reader_id = 1
    GROUP BY genre
    ORDER BY AVG(rating) DESC
    LIMIT 2
)
AND b.book_id NOT IN (
    SELECT book_id
    FROM reading_log
    WHERE reader_id = 1
)
ORDER BY RANDOM()
LIMIT 5;















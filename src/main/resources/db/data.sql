INSERT INTO `books` (`title`) VALUES ('The Great Gatsby');
INSERT INTO `books` (`title`) VALUES ('The Bell Jar');
INSERT INTO `books` (`title`) VALUES ('I Know Why the Caged Bird Sings');

# INSERT INTO 'books' ('title')
# SELECT 'The Great Gatsby' FROM DUAL
# WHERE NOT EXISTS (SELECT * FROM books WHERE 'books'.'title' = 'The Great Gatsby');
#
# INSERT INTO 'books' ('title')
# SELECT 'The Bell Jar' FROM DUAL
# WHERE NOT EXISTS (SELECT * FROM books WHERE 'books'.'title' = 'The Bell Jar');
#
# INSERT INTO 'books' ('title')
# SELECT 'I Know Why the Caged Bird Sings' FROM DUAL
# WHERE NOT EXISTS (SELECT * FROM books WHERE 'books'.'title' = 'I Know Why the Caged Bird Sings');
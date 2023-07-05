package org.lerkasan.capstone.service;

import org.lerkasan.capstone.model.Book;
import org.lerkasan.capstone.repository.BookRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookService implements BookServiceI {

    private final BookRepository bookRepository;

    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public List<Book> getBooks() {
        return bookRepository.findAll();
    }
}

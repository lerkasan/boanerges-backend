package org.lerkasan.capstone.controller;

import org.lerkasan.capstone.model.Book;
import org.lerkasan.capstone.service.BookServiceI;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@RestController
@RequestMapping(value = "/api/v1/books", produces = APPLICATION_JSON_VALUE)
public class BookController {

    private final BookServiceI bookService;

    public BookController(BookServiceI bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public List<Book> getBooks() {
        return bookService.getBooks();
    }
}

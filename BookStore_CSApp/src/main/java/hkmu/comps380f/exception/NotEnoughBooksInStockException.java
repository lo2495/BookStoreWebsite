package hkmu.comps380f.exception;

import hkmu.comps380f.model.Book;

public class NotEnoughBooksInStockException extends Exception{
    private static final String DEFAULT_MESSAGE = "Not enough products in stock";

    public NotEnoughBooksInStockException() {
        super(DEFAULT_MESSAGE);
    }

    public NotEnoughBooksInStockException(Book book) {
        super(String.format("Not enough %s products in stock. Only %d left", book.getBookname(), book.getQuantity()));
    }
}

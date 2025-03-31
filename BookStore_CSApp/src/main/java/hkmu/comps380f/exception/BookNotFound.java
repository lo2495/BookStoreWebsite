package hkmu.comps380f.exception;

import java.util.UUID;

public class BookNotFound extends Exception {
    public BookNotFound(long id) {
        super("Book " + id + " does not exist.");
    }
}
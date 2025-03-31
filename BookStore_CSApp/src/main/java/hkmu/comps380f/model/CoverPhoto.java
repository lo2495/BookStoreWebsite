package hkmu.comps380f.model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;

import java.util.Arrays;
import java.util.UUID;


@Entity
public class CoverPhoto {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    @Column(name = "filename")
    private String  name;
    @Column(name = "content_type")
    private String mimecontentType;
    @Lob
    @Basic(fetch = FetchType.LAZY)
    @Column(name = "content")
    private byte[] contents;
    @Column(name = "book_id", insertable=false, updatable=false)
    private long bookId;
    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book book;

    public CoverPhoto() {}

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMimecontentType() {
        return mimecontentType;
    }

    public void setMimecontentType(String mimecontentType) {
        this.mimecontentType = mimecontentType;
    }

    public byte[] getContents() {
        return contents;
    }

    public void setContents(byte[] contents) {
        this.contents = contents;
    }

    public long getBookId() {
        return bookId;
    }

    public void setBookId(long bookId) {
        this.bookId = bookId;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    @Override
    public String toString() {
        return "CoverPhoto{" +
                "name='" + name + '\'' +
                ", mimecontentType='" + mimecontentType + '\'' +
                ", contents=" + Arrays.toString(contents) +
                ", bookId=" + bookId +
                '}';
    }
}
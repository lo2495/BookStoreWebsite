package hkmu.comps380f.dao;

import hkmu.comps380f.model.Book;
import hkmu.comps380f.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUsername(String username);
    Order findByUsernameAndId(String username, Long id);
    @Query("SELECT o FROM Order o JOIN o.items item WHERE KEY(item) = :book")
    List<Order> findOrdersByBook(@Param("book") Book book);
}

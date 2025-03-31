package hkmu.comps380f.dao;

import hkmu.comps380f.model.AppUser;
import hkmu.comps380f.model.CoverPhoto;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface CoverPhotoRepository extends JpaRepository<CoverPhoto, Long> {
    CoverPhoto findByBookId(long bookId);
    List<CoverPhoto> findByBookIdIn(List<Long> bookId);
}

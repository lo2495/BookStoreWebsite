package hkmu.comps380f.model;

import jakarta.persistence.*;

@Entity
@Table(name = "userrole")
public class UserRole {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private int USER_ROLE_ID;

    @Column
    private String username;

    private String role;
    @ManyToOne
    @JoinColumn(name = "username", referencedColumnName = "username", insertable = false, updatable = false)
    private AppUser user;

    public UserRole() {
    }

    public UserRole(AppUser user, String role) {
        this.user = user;
        this.role = role;
    }

    public void setUSER_ROLE_ID(int USER_ROLE_ID) {
        this.USER_ROLE_ID = USER_ROLE_ID;
    }

    public int getUSER_ROLE_ID() {
        return USER_ROLE_ID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public AppUser getUser() {
        return user;
    }

    public void setUser(AppUser user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "UserRole{" +
                "username='" + username + '\'' +
                ", role='" + role + '\'' +
                '}';
    }
}
package br.com.hematsu.stock_flow.dto;

import org.springframework.beans.BeanUtils;

import br.com.hematsu.stock_flow.entities.User;

public class UserDTO {
    private Long userId;
    private String username;
    private String password;
    private String name;

    public UserDTO() {
    }

    public UserDTO(User user){
        BeanUtils.copyProperties(user, this);
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "UserDTO [userId=" + userId + ", username=" + username + ", password=" + password + ", name=" + name
                + "]";
    }
}

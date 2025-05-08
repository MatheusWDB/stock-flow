package br.com.hematsu.stock_flow.dtos;

import br.com.hematsu.stock_flow.entities.User;
import br.com.hematsu.stock_flow.enums.UserRole;

public record UserDTO(String username, String password, String name, UserRole role) {

    public UserDTO(User user) {
        this(
                user.getUsername(),
                user.getPassword(),
                user.getName(),
                user.getRole());
    }
}
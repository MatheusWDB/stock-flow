package br.com.hematsu.stock_flow.dtos;

import br.com.hematsu.stock_flow.entities.User;

public record UserDTO(
        String username, String password,
        String name) {

    public UserDTO(User user) {
        this(
                user.getUsername(),
                user.getPassword(),
                user.getName());
    }
}
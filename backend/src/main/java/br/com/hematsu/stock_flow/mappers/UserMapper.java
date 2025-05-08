package br.com.hematsu.stock_flow.mappers;

import org.springframework.stereotype.Component;

import br.com.hematsu.stock_flow.dtos.UserDTO;
import br.com.hematsu.stock_flow.entities.User;

@Component
public class UserMapper {

    public UserDTO toDTO(User user) {
        return new UserDTO(user);
    }

    public User toEntity(UserDTO userDTO) {
        return new User(userDTO.username(), userDTO.password(), userDTO.name());
    }

}

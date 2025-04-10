package br.com.hematsu.stock_flow.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.hematsu.stock_flow.dto.UserDTO;
import br.com.hematsu.stock_flow.entities.User;
import br.com.hematsu.stock_flow.mappers.UserMapper;
import br.com.hematsu.stock_flow.services.UserService;


@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserMapper userMapper;

    @PostMapping
    public ResponseEntity<Void> createUser(@RequestBody UserDTO userDTO) {
        User newUser = userMapper.toEntity(userDTO);

        newUser = userService.crypt(newUser);

        userService.save(newUser);

        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @GetMapping("/{userId}")
    public ResponseEntity<UserDTO> getUserById(@PathVariable Long userId) {
        UserDTO user = userMapper.toDTO(userService.findById(userId));
        return ResponseEntity.ok().body(user);
    }
    

}

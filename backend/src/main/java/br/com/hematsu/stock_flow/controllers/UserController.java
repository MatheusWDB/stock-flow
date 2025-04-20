package br.com.hematsu.stock_flow.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.hematsu.stock_flow.dtos.UserDTO;
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
    public ResponseEntity<Void> registerUser(@RequestBody UserDTO userDTO) {
        userService.emailExists(userDTO.getEmail());

        User newUser = userMapper.toEntity(userDTO);

        newUser = userService.hashUserPassword(newUser);

        userService.save(newUser);

        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @PostMapping("/login")
    public ResponseEntity<User> login(@RequestBody UserDTO userDTO) {        
        User user = userService.findByEmail(userDTO.getEmail());

        userService.checkPassword(userDTO.getPassword(), user.getPassword());

        //gerar token e devolver

        return ResponseEntity.status(HttpStatus.OK).body(user);
    }

}

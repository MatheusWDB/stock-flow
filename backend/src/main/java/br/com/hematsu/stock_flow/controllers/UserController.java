package br.com.hematsu.stock_flow.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.hematsu.stock_flow.dtos.UserDTO;
import br.com.hematsu.stock_flow.dtos.UserResponseDTO;
import br.com.hematsu.stock_flow.entities.User;
import br.com.hematsu.stock_flow.mappers.UserMapper;
import br.com.hematsu.stock_flow.services.TokenService;
import br.com.hematsu.stock_flow.services.UserService;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private TokenService tokenService;

    @PostMapping("register")
    public ResponseEntity<Void> registerUser(@RequestBody @Valid UserDTO userDTO) {

        userService.emailExists(userDTO.username());

        User newUser = userMapper.toEntity(userDTO);

        String encryptedPassword = new BCryptPasswordEncoder().encode(userDTO.password());

        newUser.setPassword(encryptedPassword);

        userService.save(newUser);

        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @PostMapping("/login")
    public ResponseEntity<UserResponseDTO> login(@RequestBody @Valid UserDTO userDTO) {
        UsernamePasswordAuthenticationToken usernamePassword = new UsernamePasswordAuthenticationToken(
                userDTO.username(), userDTO.password());

        Authentication auth = this.authenticationManager.authenticate(usernamePassword);

        String token = tokenService.generateToken((User) auth.getPrincipal());

        //System.out.println((User) auth.getPrincipal());

        return ResponseEntity.status(HttpStatus.OK).body(new UserResponseDTO(token));
    }

}

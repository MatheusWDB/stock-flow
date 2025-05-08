package br.com.hematsu.stock_flow.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import br.com.hematsu.stock_flow.entities.User;
import br.com.hematsu.stock_flow.exceptions.user.InvalidCredentialsException;
import br.com.hematsu.stock_flow.exceptions.user.UserAlreadyExistsException;
import br.com.hematsu.stock_flow.repositories.UserRepository;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    public User save(User user) {
        return userRepository.save(user);
    }

    public User findById(Long userId) {
        return userRepository.findById(userId).orElse(null);
    }

    public void emailExists(String username) {
        UserDetails user = userRepository.findByUsername(username);

        if (user != null)
            throw new UserAlreadyExistsException();
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserDetails user = userRepository.findByUsername(username);

        if (user == null)
            throw new InvalidCredentialsException("Email não cadastrado!");

        return user;
    }

}

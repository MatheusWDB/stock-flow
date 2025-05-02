package br.com.hematsu.stock_flow.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import at.favre.lib.crypto.bcrypt.BCrypt;
import br.com.hematsu.stock_flow.entities.User;
import br.com.hematsu.stock_flow.exceptions.user.InvalidCredentialsException;
import br.com.hematsu.stock_flow.exceptions.user.UserAlreadyExistsException;
import br.com.hematsu.stock_flow.repositories.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User save(User user) {
        return userRepository.save(user);
    }

    public User findById(Long userId) {
        return userRepository.findById(userId).orElse(null);
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new InvalidCredentialsException("Email não cadastrado!"));
    }

    public User hashUserPassword(User user) {
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, user.getPassword().toCharArray());

        user.setPassword(bcryptHashString);

        return user;
    }

    public void emailExists(String email) {
        User user = userRepository.findByEmail(email).orElse(null);

        if (user != null)
            throw new UserAlreadyExistsException();
    }

    public void checkPassword(String password, String bcryptHash) {
        BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), bcryptHash);

        if (!result.verified) {
            throw new InvalidCredentialsException("Senha incorreta!");
        }
    }

}

package br.com.hematsu.stock_flow.exceptions.user;

public class UserAlreadyExistsException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public UserAlreadyExistsException() {
        super("E-mail já cadastrado!");
    }
}

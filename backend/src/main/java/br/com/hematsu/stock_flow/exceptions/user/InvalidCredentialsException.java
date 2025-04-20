package br.com.hematsu.stock_flow.exceptions.user;

public class InvalidCredentialsException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public InvalidCredentialsException(String msg) {
        super(msg);
    }
}

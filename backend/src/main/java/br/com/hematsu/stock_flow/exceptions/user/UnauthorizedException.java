package br.com.hematsu.stock_flow.exceptions.user;

public class UnauthorizedException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public UnauthorizedException() {
        super("Precisa logar para ter autorização!");
    }
}

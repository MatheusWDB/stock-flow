package br.com.hematsu.stock_flow.exceptions.movement;

public class InvalidMovementTypeException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public InvalidMovementTypeException() {
        super("Tipo de movimentação inválido!");
    }
}

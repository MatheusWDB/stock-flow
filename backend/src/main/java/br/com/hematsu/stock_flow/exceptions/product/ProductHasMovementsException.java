package br.com.hematsu.stock_flow.exceptions.product;

public class ProductHasMovementsException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public ProductHasMovementsException() {
        super("Existe movimentações com esse produto!");
    }
}

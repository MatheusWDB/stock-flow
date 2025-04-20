package br.com.hematsu.stock_flow.exceptions.product;

public class ProductNotFoundException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public ProductNotFoundException() {
        super("Produto não encontrado!");
    }
}

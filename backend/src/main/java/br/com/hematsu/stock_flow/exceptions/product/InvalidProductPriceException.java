package br.com.hematsu.stock_flow.exceptions.product;

public class InvalidProductPriceException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public InvalidProductPriceException() {
        super("O preço de venda é maior que o de custo!");
    }
}

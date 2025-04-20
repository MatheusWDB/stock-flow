package br.com.hematsu.stock_flow.exceptions.movement;

public class InsufficientStockException  extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public InsufficientStockException () {
        super("Esse produto não possui quantidade suficiente para essa movimentação!");
    }
}

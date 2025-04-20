package br.com.hematsu.stock_flow.exceptions.product;

public class DuplicateProductCodeException extends RuntimeException{
    private static final long serialVersionUID = 1L;
    
    public DuplicateProductCodeException(){
        super("Código de produto já existe!");
    }    
}

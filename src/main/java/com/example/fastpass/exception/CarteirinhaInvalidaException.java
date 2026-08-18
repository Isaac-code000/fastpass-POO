package com.example.fastpass.exception;

public class CarteirinhaInvalidaException extends RuntimeException{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public CarteirinhaInvalidaException(String mensagem) {
        super(mensagem);
    }

    public CarteirinhaInvalidaException() {
        super("A carteirinha informada está invalida em nosso sistema.");
	
	
	
    }
	
}

	
	
	


package com.example.fastpass.exception;

public class PasseVencidoException extends RuntimeException {

   

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public PasseVencidoException(String mensagem) {
        super(mensagem);
    }

    public PasseVencidoException() {
        super("O passe informado está vencido.");
    }
}
package com.example.fastpass.exception;

public class PasseNaoEncontradoException extends RuntimeException{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public PasseNaoEncontradoException(String mensagem) {
        super(mensagem);
    }

    public PasseNaoEncontradoException() {
        super("O passe informado não foi encontrado em nosso sistema.");
	
	
	
    }
	
}

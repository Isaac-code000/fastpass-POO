package com.example.fastpass.exception;

public class PasseNaoEncontradoException extends RuntimeException {
    public PasseNaoEncontradoException(String mensagem) {
        super(mensagem);
    }
}

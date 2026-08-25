package com.example.fastpass.exception;

public class PasseVencidoException extends RuntimeException {
    public PasseVencidoException(String mensagem) {
        super(mensagem);
    }
}
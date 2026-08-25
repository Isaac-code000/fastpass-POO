package com.example.fastpass.exception;

public class CarteirinhaNaoEncontradaException extends RuntimeException {
    public CarteirinhaNaoEncontradaException(String mensagem) {
        super(mensagem);
    }
}

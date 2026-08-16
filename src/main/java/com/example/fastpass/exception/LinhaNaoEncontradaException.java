package com.example.fastpass.exception;

public class LinhaNaoEncontradaException extends RuntimeException {
    public LinhaNaoEncontradaException(Long id) {
        super("Nenhuma linha encontrada com o id " + id + ".");
    }
}
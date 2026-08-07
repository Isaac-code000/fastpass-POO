package com.example.fastpass.exception;

public class CredenciaisInvalidasException extends RuntimeException {
    public CredenciaisInvalidasException() {
        super("Apelido ou senha inválidos.");
    }
}
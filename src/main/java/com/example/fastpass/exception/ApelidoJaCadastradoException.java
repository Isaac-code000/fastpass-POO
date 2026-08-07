package com.example.fastpass.exception;

public class ApelidoJaCadastradoException extends RuntimeException {
    public ApelidoJaCadastradoException(String apelido) {
        super("O apelido '" + apelido + "' já está em uso por outro usuário.");
    }
}

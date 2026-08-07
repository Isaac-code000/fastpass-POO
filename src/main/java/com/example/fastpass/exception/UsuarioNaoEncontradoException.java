package com.example.fastpass.exception;

public class UsuarioNaoEncontradoException extends RuntimeException {
    public UsuarioNaoEncontradoException(String apelido) {
        super("Nenhum usuário encontrado com o apelido '" + apelido + "'.");
    }
}

package com.example.fastpass.exception;

public class UsuarioNaoEncontradoException extends RuntimeException {
    public UsuarioNaoEncontradoException(String apelido) {
        super("Nenhum usuário encontrado com o apelido '" + apelido + "'.");
    }

    public UsuarioNaoEncontradoException(Long id) {
        super("Nenhum usuário encontrado com o id " + id + ".");
    }
}
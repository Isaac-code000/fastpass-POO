package com.example.fastpass.exception;

public class LoginBloqueadoException extends RuntimeException {
    public LoginBloqueadoException(String apelido) {
        super("Login '" + apelido + "' está bloqueado após múltiplas tentativas falhas.");
    }
}

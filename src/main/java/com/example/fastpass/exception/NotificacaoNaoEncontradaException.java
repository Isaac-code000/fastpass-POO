package com.example.fastpass.exception;

public class NotificacaoNaoEncontradaException extends RuntimeException {
    public NotificacaoNaoEncontradaException(Long id) {
        super("Nenhuma notificação encontrada com o id " + id + ".");
    }
}
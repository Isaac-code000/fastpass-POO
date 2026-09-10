package com.example.fastpass.exception;

public class HistoricoNaoEncontradoException extends RuntimeException {
    public HistoricoNaoEncontradoException(String mensagem) {
        super(mensagem);
    }
}
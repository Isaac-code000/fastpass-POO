package com.example.fastpass.dto;

import com.example.fastpass.model.Notificacao;

import java.time.LocalDateTime;

public class NotificacaoResponse {

    private final Long id;
    private final String mensagem;
    private final boolean visualizada;
    private final LocalDateTime dataEnvio;

    public NotificacaoResponse(Notificacao notificacao) {
        this.id = notificacao.getId();
        this.mensagem = notificacao.getMensagem();
        this.visualizada = notificacao.isVisualizada();
        this.dataEnvio = notificacao.getDataEnvio();
    }

    public Long getId() { return id; }
    public String getMensagem() { return mensagem; }
    public boolean isVisualizada() { return visualizada; }
    public LocalDateTime getDataEnvio() { return dataEnvio; }
}
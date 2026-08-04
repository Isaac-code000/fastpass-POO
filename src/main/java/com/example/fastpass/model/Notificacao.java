package com.example.fastpass.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
public class Notificacao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String mensagem;
    private boolean visualizada;
    private LocalDateTime dataEnvio;

    @ManyToOne
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;

    public Notificacao() {}

    public Notificacao(String mensagem, Usuario usuario) {
        this.mensagem = mensagem;
        this.usuario = usuario;
        this.visualizada = false;
    }

    /**
     * Marca a data de envio como agora. Chamado pelo Service ao criar
     * e persistir a notificação — não faz chamada de rede nenhuma aqui,
     * é só o registro do momento em que ela "nasceu" no sistema.
     */
    public void enviar() {
        this.dataEnvio = LocalDateTime.now();
    }

    public void marcarComoLida() {
        this.visualizada = true;
    }

    public Long getId() { return id; }

    public String getMensagem() { return mensagem; }
    public void setMensagem(String mensagem) { this.mensagem = mensagem; }

    public boolean isVisualizada() { return visualizada; }

    public LocalDateTime getDataEnvio() { return dataEnvio; }

    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }
}

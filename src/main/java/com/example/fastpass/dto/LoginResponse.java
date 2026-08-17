package com.example.fastpass.dto;

import com.example.fastpass.model.Usuario;

public class LoginResponse {

    private final Long usuarioId;
    private final String nome;
    private final boolean autenticado;

    public LoginResponse(Usuario usuario) {
        this.usuarioId = usuario.getId();
        this.nome = usuario.getNome();
        this.autenticado = true;
    }

    public Long getUsuarioId() { return usuarioId; }
    public String getNome() { return nome; }
    public boolean isAutenticado() { return autenticado; }
}

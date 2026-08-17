package com.example.fastpass.dto;

import jakarta.validation.constraints.NotBlank;

public class LoginRequest {

    @NotBlank(message = "Apelido é obrigatório")
    private String apelido;

    @NotBlank(message = "Senha é obrigatória")
    private String senha;

    public LoginRequest() {}

    public String getApelido() { return apelido; }
    public void setApelido(String apelido) { this.apelido = apelido; }

    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }
}

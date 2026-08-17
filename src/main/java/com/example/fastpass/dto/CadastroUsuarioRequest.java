package com.example.fastpass.dto;

import jakarta.validation.constraints.*;

public class CadastroUsuarioRequest {

    @NotBlank(message = "Nome é obrigatório")
    private String nome;

    @NotBlank(message = "E-mail é obrigatório")
    @Email(message = "E-mail inválido")
    private String email;

    @NotBlank(message = "CPF é obrigatório")
    @Pattern(regexp = "\\d{11}", message = "CPF deve conter 11 dígitos numéricos")
    private String cpf;

    @NotBlank(message = "Apelido é obrigatório")
    private String apelido;

    @NotBlank(message = "Senha é obrigatória")
    @Size(min = 6, message = "Senha deve ter no mínimo 6 caracteres")
    private String senha;

    public CadastroUsuarioRequest() {}

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getCpf() { return cpf; }
    public void setCpf(String cpf) { this.cpf = cpf; }

    public String getApelido() { return apelido; }
    public void setApelido(String apelido) { this.apelido = apelido; }

    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }
}

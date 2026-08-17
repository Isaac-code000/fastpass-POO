package com.example.fastpass.dto;

import com.example.fastpass.model.Usuario;

// Repare: NÃO tem campo "senha" nem "login" aqui — é assim que evitamos
// devolver dado sensível numa resposta HTTP, mesmo que a entidade
// Usuario internamente tenha acesso a esses dados via o Login associado.
public class UsuarioResponse {

    private final Long id;
    private final String nome;
    private final String email;
    private final String cpf;

    public UsuarioResponse(Usuario usuario) {
        this.id = usuario.getId();
        this.nome = usuario.getNome();
        this.email = usuario.getEmail();
        this.cpf = usuario.getCpf();
    }

    public Long getId() { return id; }
    public String getNome() { return nome; }
    public String getEmail() { return email; }
    public String getCpf() { return cpf; }
}

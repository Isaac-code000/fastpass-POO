package com.example.fastpass.dto;

import com.example.fastpass.model.Carteirinha;

public class CarteirinhaResponse {
    private final Long id;
    private final String matricula;
    private final String instituicao;
    private final String curso;
    private final String validade;
    private final boolean valida;
    private final String nomeUsuario;
    private final String apelidoUsuario;

    public CarteirinhaResponse(Carteirinha carteirinha) {
        this.id = carteirinha.getId();
        this.matricula = carteirinha.getMatricula();
        this.instituicao = carteirinha.getInstituicao();
        this.curso = carteirinha.getCurso();
        this.validade = carteirinha.getValidade().toString();
        this.valida = carteirinha.validar();
        this.nomeUsuario = carteirinha.getUsuario().getNome();
        this.apelidoUsuario = carteirinha.getUsuario().getLogin().getApelido();
    }

    public Long getId() { return id; }
    public String getMatricula() { return matricula; }
    public String getInstituicao() { return instituicao; }
    public String getCurso() { return curso; }
    public String getValidade() { return validade; }
    public boolean isValida() { return valida; }
    public String getNomeUsuario() { return nomeUsuario; }
    public String getApelidoUsuario() { return apelidoUsuario; }
}

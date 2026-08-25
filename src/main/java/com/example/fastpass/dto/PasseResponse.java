package com.example.fastpass.dto;

import com.example.fastpass.model.Passe;

public class PasseResponse {
    private final Long id;
    private final double saldo;
    private final String validade;
    private final String status;
    private final String tipo;

    public PasseResponse(Passe passe) {
        this.id = passe.getId();
        this.saldo = passe.getSaldo();
        this.validade = passe.getValidade().toString();
        this.status = passe.getStatus().name();
        this.tipo = passe.getTipo().name();
    }

    public Long getId() { return id; }
    public double getSaldo() { return saldo; }
    public String getValidade() { return validade; }
    public String getStatus() { return status; }
    public String getTipo() { return tipo; }
}
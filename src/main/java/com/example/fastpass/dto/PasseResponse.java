package com.example.fastpass.dto;

import java.time.LocalDate;
import com.example.fastpass.model.Passe;
import com.example.fastpass.model.StatusPasse;
import com.example.fastpass.model.TipoPasse;

public class PasseResponse {

    private Long id;
    private Double saldo;
    private LocalDate dataValidade;
    private StatusPasse status;
    private TipoPasse tipo;

    public PasseResponse(Passe passe) {
        this.id = passe.getId();
        this.saldo = passe.getSaldo();
        this.dataValidade = passe.getValidade();
        this.status = passe.getStatus();
        this.tipo = passe.getTipo();
    }

    // Getters
    public Long getId() { return id; }
    public Double getSaldo() { return saldo; }
    public LocalDate getDataValidade() { return dataValidade; }
    public StatusPasse getStatus() { return status; }
    public TipoPasse getTipo() { return tipo; }
}
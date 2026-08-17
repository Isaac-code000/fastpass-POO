package com.example.fastpass.dto;

import com.example.fastpass.model.Linha;

public class LinhaResponse {

    private final Long id;
    private final String numero;
    private final String nomeRota;
    private final String origem;
    private final String destino;

    public LinhaResponse(Linha linha) {
        this.id = linha.getId();
        this.numero = linha.getNumero();
        this.nomeRota = linha.getNomeRota();
        this.origem = linha.getOrigem();
        this.destino = linha.getDestino();
    }

    public Long getId() { return id; }
    public String getNumero() { return numero; }
    public String getNomeRota() { return nomeRota; }
    public String getOrigem() { return origem; }
    public String getDestino() { return destino; }
}

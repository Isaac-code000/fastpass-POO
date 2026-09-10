package com.example.fastpass.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "tb_historico_uso")
public class HistoricoUso {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String localUso;
    private Double valorDebitado;
    private LocalDateTime dataHora;

    public HistoricoUso() {
        this.dataHora = LocalDateTime.now();
    }

    public HistoricoUso(String localUso, Double valorDebitado) {
        this();
        this.localUso = localUso;
        this.valorDebitado = valorDebitado;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getLocalUso() { return localUso; }
    public void setLocalUso(String localUso) { this.localUso = localUso; }

    public Double getValorDebitado() { return valorDebitado; }
    public void setValorDebitado(Double valorDebitado) { this.valorDebitado = valorDebitado; }

    public LocalDateTime getDataHora() { return dataHora; }
    public void setDataHora(LocalDateTime dataHora) { this.dataHora = dataHora; }
}
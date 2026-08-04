package com.example.fastpass.model;

import jakarta.persistence.*;
import java.time.LocalTime;

@Entity
public class Horario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalTime horarioSaida;
    private LocalTime horarioChegada;

    // Intervalo já formatado, ex: "Seg a Sex", "Seg a Sáb" — bate com o
    // que o front-end espera (ver contrato de API).
    private String diasSemana;

    @ManyToOne
    @JoinColumn(name = "linha_id")
    private Linha linha;

    public Horario() {}

    public Horario(LocalTime horarioSaida, LocalTime horarioChegada, String diasSemana) {
        this.horarioSaida = horarioSaida;
        this.horarioChegada = horarioChegada;
        this.diasSemana = diasSemana;
    }

    public Long getId() { return id; }

    public LocalTime getHorarioSaida() { return horarioSaida; }
    public void setHorarioSaida(LocalTime horarioSaida) { this.horarioSaida = horarioSaida; }

    public LocalTime getHorarioChegada() { return horarioChegada; }
    public void setHorarioChegada(LocalTime horarioChegada) { this.horarioChegada = horarioChegada; }

    public String getDiasSemana() { return diasSemana; }
    public void setDiasSemana(String diasSemana) { this.diasSemana = diasSemana; }

    public Linha getLinha() { return linha; }
    public void setLinha(Linha linha) { this.linha = linha; }
}

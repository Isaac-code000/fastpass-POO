package com.example.fastpass.dto;

import com.example.fastpass.model.Horario;

import java.time.format.DateTimeFormatter;

public class HorarioResponse {

    private static final DateTimeFormatter FORMATO_HORA = DateTimeFormatter.ofPattern("HH:mm");

    private final String horarioSaida;
    private final String horarioChegada;
    private final String diasSemana;

    public HorarioResponse(Horario horario) {
        // A entidade guarda LocalTime, mas o contrato de API espera uma
        // String no formato "05:40" — essa conversão acontece aqui,
        // na "porta de saída", não dentro do Model.
        this.horarioSaida = horario.getHorarioSaida().format(FORMATO_HORA);
        this.horarioChegada = horario.getHorarioChegada().format(FORMATO_HORA);
        this.diasSemana = horario.getDiasSemana();
    }

    public String getHorarioSaida() { return horarioSaida; }
    public String getHorarioChegada() { return horarioChegada; }
    public String getDiasSemana() { return diasSemana; }
}

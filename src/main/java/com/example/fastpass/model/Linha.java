package com.example.fastpass.model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Linha {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Número identificador da linha, ex: "101".
    private String numero;

    // Nome descritivo da rota, ex: "Centro / Terminal Norte".
    private String nomeRota;

    // Pontos de parada — diferente do nomeRota, que é só o "apelido" da rota.
    private String origem;
    private String destino;

    @OneToMany(mappedBy = "linha", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Horario> horarios = new ArrayList<>();

    public Linha() {}

    public Linha(String numero, String nomeRota, String origem, String destino) {
        this.numero = numero;
        this.nomeRota = nomeRota;
        this.origem = origem;
        this.destino = destino;
    }

    public Long getId() { return id; }

    public String getNumero() { return numero; }
    public void setNumero(String numero) { this.numero = numero; }

    public String getNomeRota() { return nomeRota; }
    public void setNomeRota(String nomeRota) { this.nomeRota = nomeRota; }

    public String getOrigem() { return origem; }
    public void setOrigem(String origem) { this.origem = origem; }

    public String getDestino() { return destino; }
    public void setDestino(String destino) { this.destino = destino; }

    public List<Horario> getHorarios() { return horarios; }

    public void adicionarHorario(Horario horario) {
        horarios.add(horario);
        horario.setLinha(this);
    }
}

package com.example.fastpass.model;

import java.time.LocalDate;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "tb_passe")
public class Passe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private double saldo;
    private LocalDate validade;

    @Enumerated(EnumType.STRING)
    private StatusPasse status;

    @Enumerated(EnumType.STRING)
    private TipoPasse tipo;

    public Passe() {
    }

    public Passe(double saldo, LocalDate validade, StatusPasse status, TipoPasse tipo) {
        this.saldo = saldo;
        this.validade = validade;
        this.status = status;
        this.tipo = tipo;
    }

    public double consultarSaldo() {
        return this.saldo;
    }

    public boolean debitar(double valor) {
        if (valor > 0 && this.saldo >= valor) {
            this.saldo -= valor;
            return true;
        }
        return false;
    }

    public void recarregar(double valor) {
        if (valor > 0) {
            this.saldo = this.saldo + valor;
        }
    }

    public boolean validar() {
        return this.status == StatusPasse.ATIVO  && this.validade.isAfter(LocalDate.now());
    }
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public double getSaldo() {
        return saldo;
    }

    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }

    public LocalDate getValidade() {
        return validade;
    }

    public void setValidade(LocalDate validade) {
        this.validade = validade;
    }

    public StatusPasse getStatus() {
        return status;
    }

    public void setStatus(StatusPasse status) {
        this.status = status;
    }

    public TipoPasse getTipo() {
        return tipo;
    }

    public void setTipo(TipoPasse tipo) {
        this.tipo = tipo;
    }
}
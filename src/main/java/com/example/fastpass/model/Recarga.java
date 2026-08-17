package com.example.fastpass.model;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import java.time.LocalDate;

/**
 * Representa o evento de recarregar o passe. Toda recarga é feita através
 * de um Pagamento (Pix ou Debito) — a associação é 1 para 1, conforme o
 * diagrama de classes.
 */
@Entity
public class Recarga {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private double valor;

    private LocalDate data;

    @Enumerated(EnumType.STRING)
    private StatusRecarga status;

    @OneToOne
    @JoinColumn(name = "pagamento_id")
    private Pagamento pagamento;

    protected Recarga() {
        // construtor padrão exigido pelo JPA
    }

    public Recarga(double valor, LocalDate data, Pagamento pagamento) {
        this.valor = valor;
        this.data = data;
        this.pagamento = pagamento;
        this.status = StatusRecarga.PENDENTE;
    }

    /**
     * Confirma a recarga processando o pagamento vinculado.
     * RN03: uma recarga só é confirmada após a validação do pagamento simulado.
     */
    public boolean confirmar() {
        if (pagamento != null && pagamento.processarPagamento()) {
            this.status = StatusRecarga.CONFIRMADA;
            return true;
        }
        this.status = StatusRecarga.CANCELADA;
        return false;
    }

    public Long getId() {
        return id;
    }

    public double getValor() {
        return valor;
    }

    public LocalDate getData() {
        return data;
    }

    public StatusRecarga getStatus() {
        return status;
    }

    public Pagamento getPagamento() {
        return pagamento;
    }
}

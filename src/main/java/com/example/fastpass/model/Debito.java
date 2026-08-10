package com.example.fastpass.model;

import jakarta.persistence.Entity;

@Entity
public class Debito extends Pagamento {

    private double desconto;

    protected Debito() {
        super();
    }

    public Debito(double valor, double desconto) {
        super(valor);
        this.desconto = desconto;
    }

    @Override
    public boolean processarPagamento() {
        // Pagamento via cartão de Débito simulado.
        return getValor() > 0 && desconto >= 0;
    }

    public double getDesconto() {
        return desconto;
    }

    public void setDesconto(double desconto) {
        this.desconto = desconto;
    }
}

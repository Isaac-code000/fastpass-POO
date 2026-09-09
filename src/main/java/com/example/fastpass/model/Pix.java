package com.example.fastpass.model;

import jakarta.persistence.Entity;

@Entity
public class Pix extends Pagamento {

    private String chavePix;

    protected Pix() {
        super();
    }

    public Pix(double valor, String chavePix) {
        super(valor);
        this.chavePix = chavePix;
    }


    @Override
    public boolean processarPagamento() {
        return getValor() > 0;
    }

    public String getChavePix() {
        return chavePix;
    }

    public void setChavePix(String chavePix) {
        this.chavePix = chavePix;
    }
}

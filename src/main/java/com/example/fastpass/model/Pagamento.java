package com.example.fastpass.model;

import com.example.fastpass.exception.ValorInvalidoException;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;

/**
 * Classe base para qualquer forma de pagamento.
 *
 * @Inheritance(strategy = JOINED) diz ao Hibernate para criar uma tabela
 * "pagamento" com os campos comuns (id, valor) e uma tabela separada para
 * cada subclasse (pix, debito) contendo só os campos específicos delas.
 */
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Pagamento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private double valor;

    protected Pagamento() {
        // construtor padrão exigido pelo JPA
    }

    protected Pagamento(double valor) {
        if (valor <= 0) {
            throw new ValorInvalidoException("O valor do pagamento deve ser maior que zero: " + valor);
        }
        this.valor = valor;
    }

    /**
     * Cada subtipo de pagamento implementa sua própria lógica de
     * processamento (simulada, conforme o escopo do projeto).
     */
    public abstract boolean processarPagamento();

    public Long getId() {
        return id;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }
}

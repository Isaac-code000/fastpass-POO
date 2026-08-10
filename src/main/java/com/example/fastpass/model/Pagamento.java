package com.example.fastpass.model;

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
 * As tabelas filhas se ligam à tabela pai pelo id (chave estrangeira).
 *
 * Sem essa anotação, o Hibernate não sabe como organizar as tabelas quando
 * uma entidade tem subclasses concretas.
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

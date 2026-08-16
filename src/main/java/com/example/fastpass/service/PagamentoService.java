package com.example.fastpass.service;

import com.example.fastpass.model.Pagamento;
import com.example.fastpass.repository.PagamentoRepository;
import org.springframework.stereotype.Service;

@Service
public class PagamentoService {

    private final PagamentoRepository pagamentoRepository;

    public PagamentoService(PagamentoRepository pagamentoRepository) {
        this.pagamentoRepository = pagamentoRepository;
    }

    /**
     * Processa (simula) o pagamento e persiste o registro, independente do
     * resultado — assim fica registrado tanto o pagamento aprovado quanto o
     * recusado.
     * A validação de valor <= 0 já acontece no construtor da entidade
     * Pagamento (lança ValorInvalidoException antes mesmo de chegar aqui).
     */
    public boolean processar(Pagamento pagamento) {
        boolean aprovado = pagamento.processarPagamento();
        pagamentoRepository.save(pagamento);
        return aprovado;
    }
}

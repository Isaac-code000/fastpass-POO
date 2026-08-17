package com.example.fastpass.facade;

import com.example.fastpass.exception.PagamentoRecusadoException;
import com.example.fastpass.model.Pagamento;
import com.example.fastpass.service.PagamentoService;
import com.example.fastpass.model.Recarga;
import com.example.fastpass.service.RecargaService;
import org.springframework.stereotype.Component;

@Component
public class RecargaFacade {

    private final PagamentoService pagamentoService;
    private final RecargaService recargaService;

    public RecargaFacade(PagamentoService pagamentoService, RecargaService recargaService) {
        this.pagamentoService = pagamentoService;
        this.recargaService = recargaService;
    }

    /**
     * Orquestra o fluxo completo de recarga:
     * 1. Processa o pagamento vinculado à recarga.
     * 2. Se recusado, lança PagamentoRecusadoException (a recarga nem chega
     *    a ser persistida como confirmada).
     * 3. Se aprovado, salva a recarga (status PENDENTE) e então confirma
     *    (status CONFIRMADA).
     */
    public Recarga realizarRecarga(Recarga recarga) {
        Pagamento pagamento = recarga.getPagamento();
        boolean aprovado = pagamentoService.processar(pagamento);

        if (!aprovado) {
            throw new PagamentoRecusadoException(
                    "Pagamento recusado para a recarga de valor " + recarga.getValor());
        }

        Recarga salva = recargaService.salvar(recarga);
        return recargaService.confirmar(salva.getId());
    }
}

package com.example.fastpass.controller;

import com.example.fastpass.dto.RecargaRequest;
import com.example.fastpass.dto.RecargaResponse;
import com.example.fastpass.model.Debito;
import com.example.fastpass.model.Pagamento;
import com.example.fastpass.model.Passe;
import com.example.fastpass.model.Pix;
import com.example.fastpass.model.Recarga;
import com.example.fastpass.model.StatusRecarga;
import com.example.fastpass.service.PagamentoService;
import com.example.fastpass.service.PasseService;
import com.example.fastpass.service.RecargaService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;

@RestController
@RequestMapping("/recargas")
public class RecargaController {

    private final RecargaService recargaService;
    private final PagamentoService pagamentoService;
    private final PasseService passeService;

    public RecargaController(RecargaService recargaService,
                             PagamentoService pagamentoService,
                             PasseService passeService) {
        this.recargaService = recargaService;
        this.pagamentoService = pagamentoService;
        this.passeService = passeService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<RecargaResponse> buscarPorId(@PathVariable Long id) {
        Recarga recarga = recargaService.buscarPorId(id);
        return ResponseEntity.ok(RecargaResponse.of(recarga));
    }


    @PostMapping
    public ResponseEntity<RecargaResponse> criar(@RequestBody RecargaRequest request) {
        Passe passe = passeService.consultarPasse(request.passeId());

        if (!passeService.validarSePodeRecarregar(passe)) {
            return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).build();
        }

        Pagamento pagamento = criarPagamento(request);
        pagamentoService.processar(pagamento); // persiste o pagamento (gera o id)

        Recarga recarga = new Recarga(
                request.valor(),
                LocalDate.now(),
                pagamento,
                passe
        );
        recarga = recargaService.salvar(recarga);            // status PENDENTE
        recarga = recargaService.confirmar(recarga.getId()); // define CONFIRMADA/CANCELADA

        HttpStatus status = recarga.getStatus() == StatusRecarga.CONFIRMADA
                ? HttpStatus.CREATED
                : HttpStatus.PAYMENT_REQUIRED;
        return ResponseEntity.status(status).body(RecargaResponse.of(recarga));
    }

    @PostMapping("/{id}/confirmar")
    public ResponseEntity<RecargaResponse> confirmar(@PathVariable Long id) {
        Recarga recarga = recargaService.confirmar(id);
        return ResponseEntity.ok(RecargaResponse.of(recarga));
    }

    private Pagamento criarPagamento(RecargaRequest request) {
        return switch (request.formaPagamento()) {
            case PIX -> new Pix(request.valor(), request.chavePix());
            case DEBITO -> new Debito(request.valor(), 0.0);
        };
    }
}

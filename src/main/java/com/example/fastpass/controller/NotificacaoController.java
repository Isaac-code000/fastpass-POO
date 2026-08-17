package com.example.fastpass.controller;

import com.example.fastpass.dto.NotificacaoResponse;
import com.example.fastpass.service.NotificacaoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

// AVISO: esses endpoints NÃO fazem parte do contrato de API que o
// front-end Flutter consome (notificações push reais estão fora do
// escopo do projeto). Existem só para completar a entidade Notificacao,
// caso o professor pergunte ou queira ver funcionando via Postman.
@RestController
public class NotificacaoController {

    private final NotificacaoService notificacaoService;

    public NotificacaoController(NotificacaoService notificacaoService) {
        this.notificacaoService = notificacaoService;
    }

    @GetMapping("/notificacoes")
    public List<NotificacaoResponse> listarTodas() {
        return notificacaoService.listarTodas().stream()
                .map(NotificacaoResponse::new)
                .toList();
    }

    @PatchMapping("/notificacoes/{id}/lida")
    public NotificacaoResponse marcarComoLida(@PathVariable Long id) {
        return new NotificacaoResponse(notificacaoService.marcarComoLida(id));
    }
}

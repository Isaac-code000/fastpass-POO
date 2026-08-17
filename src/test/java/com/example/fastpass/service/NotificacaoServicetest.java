package com.example.fastpass.service;

import com.example.fastpass.exception.NotificacaoNaoEncontradaException;
import com.example.fastpass.model.Notificacao;
import com.example.fastpass.repository.NotificacaoRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class NotificacaoServiceTest {

    @Mock
    private NotificacaoRepository notificacaoRepository;

    @InjectMocks
    private NotificacaoService notificacaoService;

    @Test
    void deveLancarExcecaoAoMarcarComoLidaNotificacaoInexistente() {
        when(notificacaoRepository.findById(42L)).thenReturn(Optional.empty());

        assertThrows(NotificacaoNaoEncontradaException.class,
                () -> notificacaoService.marcarComoLida(42L));
    }

    @Test
    void deveSalvarNotificacaoAoCriar() {
        when(notificacaoRepository.save(any(Notificacao.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        Notificacao criada = notificacaoService.criar(null, "Seu saldo está baixo.");

        assertEquals("Seu saldo está baixo.", criada.getMensagem());
        assertNotNull(criada.getDataEnvio(), "enviar() deveria ter preenchido a data");
    }
}
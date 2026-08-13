package com.example.fastpass.facade;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.LocalDate;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.example.fastpass.exception.CarteirinhaInvalidaException;
import com.example.fastpass.model.Carteirinha;
import com.example.fastpass.model.Passe;
import com.example.fastpass.model.StatusPasse;
import com.example.fastpass.model.TipoPasse;
import com.example.fastpass.service.CarteirinhaService;
import com.example.fastpass.service.PasseService;

@ExtendWith(MockitoExtension.class)
class PasseFacadeIntegrationTest {

    @Mock
    private PasseService passeService;

    @Mock
    private CarteirinhaService carteirinhaService;

    @InjectMocks
    private PasseFacade passeFacade;

    @Test
    @DisplayName("Deve permitir o uso do passe comum sem precisar de carteirinha")
    void devePermitirUsoDoPasseComumSemCarteirinha() {
        Passe passeComum = new Passe(10.0, LocalDate.now().plusDays(10), StatusPasse.ATIVO, TipoPasse.COMUM);
        when(passeService.consultarPasse(1L)).thenReturn(passeComum);

        boolean podeUsar = passeFacade.validarUsoDoPasse(1L, null);

        assertTrue(podeUsar);
    }

    @Test
    @DisplayName("Deve lançar exceção ao tentar usar passe ESTUDANTIL com carteirinha inválida")
    void deveLancarExcecaoParaPasseEstudantilComCarteirinhaInvalida() {
        Passe passeEstudantil = new Passe(10.0, LocalDate.now().plusDays(10), StatusPasse.ATIVO, TipoPasse.ESTUDANTIL);
        Carteirinha carteirinhaVencida = new Carteirinha("12345", "UFAPE", LocalDate.now().minusDays(1));

        when(passeService.consultarPasse(1L)).thenReturn(passeEstudantil);
        when(carteirinhaService.isValidaParaTarifaEstudantil(carteirinhaVencida)).thenReturn(false);

        assertThrows(CarteirinhaInvalidaException.class, () -> {
            passeFacade.validarUsoDoPasse(1L, carteirinhaVencida);
        });
    }
}
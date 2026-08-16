package com.example.fastpass.model;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;

import com.example.fastpass.model.Pagamento;
import com.example.fastpass.model.Pix;
import com.example.fastpass.repository.PagamentoRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

/**
 * Teste unitário — sem Spring, sem banco. O repository é mockado com
 * Mockito para isolar a lógica do service.
 */
@ExtendWith(MockitoExtension.class)
class PagamentoServiceTest {

    @Mock
    private PagamentoRepository pagamentoRepository;

    private PagamentoService pagamentoService;

    @BeforeEach
    void setUp() {
        pagamentoService = new PagamentoService(pagamentoRepository);
    }

    @Test
    void deveProcessarPagamentoValidoESalvar() {
        Pagamento pagamento = new Pix(50.0, "chave-valida");

        boolean aprovado = pagamentoService.processar(pagamento);

        assertThat(aprovado).isTrue();
        verify(pagamentoRepository).save(pagamento);
    }

    @Test
    void deveRecusarPagamentoComChavePixVazia() {
        Pagamento pagamento = new Pix(50.0, "");

        boolean aprovado = pagamentoService.processar(pagamento);

        assertThat(aprovado).isFalse();
        verify(pagamentoRepository).save(pagamento);
    }
}

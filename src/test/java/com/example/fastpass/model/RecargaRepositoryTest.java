package com.example.fastpass.model;


import static org.assertj.core.api.Assertions.assertThat;

import java.time.LocalDate;

import com.example.fastpass.repository.PagamentoRepository;
import com.example.fastpass.repository.RecargaRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

/**
 * Teste de persistência rodando contra o banco em memória H2 (configurado
 * no application-test.properties do grupo). Não depende do Docker/Postgres.
 */
@DataJpaTest
class   RecargaRepositoryTest {

    @Autowired
    private RecargaRepository recargaRepository;

    @Autowired
    private PagamentoRepository pagamentoRepository;

    @Test
    void deveSalvarERecuperarRecargaComPagamentoPix() {
        Pix pix = new Pix(50.0, "usuario@exemplo.com");
        pagamentoRepository.save(pix);

        Recarga recarga = new Recarga(50.0, LocalDate.now(), pix);
        Recarga salva = recargaRepository.save(recarga);

        Recarga encontrada = recargaRepository.findById(salva.getId()).orElseThrow();

        assertThat(encontrada.getValor()).isEqualTo(50.0);
        assertThat(encontrada.getStatus()).isEqualTo(StatusRecarga.PENDENTE);
        assertThat(encontrada.getPagamento()).isInstanceOf(Pix.class);
        assertThat(((Pix) encontrada.getPagamento()).getChavePix()).isEqualTo("usuario@exemplo.com");
    }

    @Test
    void deveConfirmarRecargaAoProcessarPagamentoValido() {
        Pix pix = new Pix(30.0, "chave-valida");
        pagamentoRepository.save(pix);
        Recarga recarga = new Recarga(30.0, LocalDate.now(), pix);

        boolean confirmada = recarga.confirmar();

        assertThat(confirmada).isTrue();
        assertThat(recarga.getStatus()).isEqualTo(StatusRecarga.CONFIRMADA);
    }
}

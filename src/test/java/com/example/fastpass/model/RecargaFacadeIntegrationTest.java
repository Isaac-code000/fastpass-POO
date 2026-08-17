package com.example.fastpass.model;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

import com.example.fastpass.exception.PagamentoRecusadoException;
import com.example.fastpass.facade.RecargaFacade;

import java.time.LocalDate;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@ActiveProfiles("test")
class RecargaFacadeIntegrationTest {

    @Autowired
    private RecargaFacade recargaFacade;

    @Test
    void deveCompletarFluxoDeRecargaComPagamentoAprovado() {
        Pix pix = new Pix(40.0, "chave-valida");
        Recarga recarga = new Recarga(40.0, LocalDate.now(), pix);

        Recarga resultado = recargaFacade.realizarRecarga(recarga);

        assertThat(resultado.getId()).isNotNull();
        assertThat(resultado.getStatus()).isEqualTo(StatusRecarga.CONFIRMADA);
    }

    @Test
    void deveRecusarRecargaComPagamentoInvalido() {
        Pix pix = new Pix(40.0, ""); // chave vazia -> pagamento simulado recusado
        Recarga recarga = new Recarga(40.0, LocalDate.now(), pix);

        assertThrows(PagamentoRecusadoException.class,
                () -> recargaFacade.realizarRecarga(recarga));
    }
}

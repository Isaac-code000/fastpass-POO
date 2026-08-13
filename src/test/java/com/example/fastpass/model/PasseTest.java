package com.example.fastpass.model;

import static org.junit.jupiter.api.Assertions.*;
import java.time.LocalDate;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class PasseTest {

    @Test
    @DisplayName("Deve debitar o valor do saldo com sucesso quando houver saldo suficiente")
    void deveDebitarSaldoComSucesso() {
        // Cenário: Passe com saldo de R$ 20.00
        Passe passe = new Passe(20.0, LocalDate.now().plusDays(30), StatusPasse.ATIVO, TipoPasse.ESTUDANTIL);

        // Ação: Debitar R$ 5.00
        boolean resultado = passe.debitar(5.0);

        // Validações
        assertTrue(resultado, "O débito deveria ter retornado true.");
        assertEquals(15.0, passe.getSaldo(), 0.001, "O saldo final deveria ser R$ 15.00.");
    }

    @Test
    @DisplayName("Não deve debitar quando o valor for maior que o saldo disponível")
    void naoDeveDebitarQuandoSaldoForInsuficiente() {
        // Cenário: Passe com apenas R$ 3.00 de saldo
        Passe passe = new Passe(3.0, LocalDate.now().plusDays(30), StatusPasse.ATIVO, TipoPasse.ESTUDANTIL);

        // Ação: Tentar debitar R$ 5.00
        boolean resultado = passe.debitar(5.0);

        // Validações
        assertFalse(resultado, "O débito deveria ter retornado false.");
        assertEquals(3.0, passe.getSaldo(), 0.001, "O saldo deveria permanecer R$ 3.00.");
    }
}
package com.example.fastpass.facade;

import com.example.fastpass.exception.ApelidoJaCadastradoException;
import com.example.fastpass.exception.CredenciaisInvalidasException;
import com.example.fastpass.model.Usuario;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@ActiveProfiles("test") // usa o application-test.properties (H2), não o Postgres real
@Transactional
class AuthFacadeIntegrationTest {

    @Autowired
    private AuthFacade authFacade;

    @Test
    void deveCadastrarEAutenticarComSucesso() {
        authFacade.cadastrar("Ana Beatriz", "ana@email.com", "12345678900", "anabeatriz", "senha123");

        Usuario autenticado = authFacade.autenticar("anabeatriz", "senha123");

        assertEquals("Ana Beatriz", autenticado.getNome());
    }

    @Test
    void naoDeveCadastrarApelidoDuplicado() {
        authFacade.cadastrar("Ana Beatriz", "ana@email.com", "12345678900", "anabeatriz", "senha123");

        assertThrows(ApelidoJaCadastradoException.class, () ->
                authFacade.cadastrar("Outra Pessoa", "outra@email.com", "00011122233", "anabeatriz", "outrasenha")
        );
    }

    @Test
    void naoDeveAutenticarComSenhaErrada() {
        authFacade.cadastrar("Ana Beatriz", "ana@email.com", "12345678900", "anabeatriz", "senha123");

        assertThrows(CredenciaisInvalidasException.class, () ->
                authFacade.autenticar("anabeatriz", "senhaErrada")
        );
    }
}

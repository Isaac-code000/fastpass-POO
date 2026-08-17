package com.example.fastpass.model;

import com.example.fastpass.exception.LoginBloqueadoException;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;


class LoginTest {

    @Test
    void deveValidarSenhaCorreta() {
        Login login = new Login("joaosilva", "senha123");

        assertTrue(login.validarSenha("senha123"));
        assertFalse(login.isBloqueado());
    }

    @Test
    void deveBloquearApos5TentativasFalhas() {
        Login login = new Login("joaosilva", "senha123");

        for (int i = 0; i < 5; i++) {
            login.validarSenha("senhaErrada");
        }

        assertTrue(login.isBloqueado());
    }

    @Test
    void deveLancarExcecaoAoValidarLoginJaBloqueado() {
        Login login = new Login("joaosilva", "senha123");
        for (int i = 0; i < 5; i++) {
            login.validarSenha("senhaErrada");
        }

        // Uma sexta tentativa, mesmo com senha certa, deve ser barrada.
        assertThrows(LoginBloqueadoException.class, () -> login.validarSenha("senha123"));
    }
}
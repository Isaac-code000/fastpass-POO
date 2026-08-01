// UsuarioRepositoryTest.java
package com.example.fastpass.model;

import com.example.fastpass.repository.UsuarioRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
class UsuarioRepositoryTest {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Test
    void deveSalvarEBuscarUsuario() {
        // montando os objetos de teste
        Login login = new Login("joaosilva", "senha123");
        Usuario usuario = new Usuario(
                "João Silva",
                "joao@email.com",
                "12345678900",
                login
        );

        // executando a ação que queremos testar
        Usuario salvo = usuarioRepository.save(usuario);

        // confere se o resultado é o esperado
        assertNotNull(salvo.getId(), "O ID deveria ter sido gerado pelo banco");

        Optional<Usuario> encontrado = usuarioRepository.findById(salvo.getId());
        assertTrue(encontrado.isPresent(), "O usuário deveria ser encontrado no banco");
        assertEquals("João Silva", encontrado.get().getNome());
        assertEquals("joaosilva", encontrado.get().getLogin().getApelido());
    }
}

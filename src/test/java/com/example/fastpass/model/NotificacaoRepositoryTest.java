package com.example.fastpass.model;

import com.example.fastpass.repository.NotificacaoRepository;
import com.example.fastpass.repository.UsuarioRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
class NotificacaoRepositoryTest {

    @Autowired
    private NotificacaoRepository notificacaoRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Test
    void deveSalvarNotificacaoAssociadaAUsuario() {
        Login login = new Login("joaosilva", "senha123");
        Usuario usuario = usuarioRepository.save(
                new Usuario("João Silva", "joao@email.com", "12345678900", login));

        Notificacao notificacao = new Notificacao("Seu saldo está baixo.", usuario);
        notificacao.enviar();

        Notificacao salva = notificacaoRepository.save(notificacao);

        assertNotNull(salva.getId());
        assertNotNull(salva.getDataEnvio(), "enviar() deveria ter preenchido a data de envio");
        assertFalse(salva.isVisualizada());
    }

    @Test
    void deveMarcarNotificacaoComoLida() {
        Login login = new Login("mariasouza", "senha456");
        Usuario usuario = usuarioRepository.save(
                new Usuario("Maria Souza", "maria@email.com", "98765432100", login));

        Notificacao notificacao = notificacaoRepository.save(
                new Notificacao("Recarga confirmada.", usuario));

        notificacao.marcarComoLida();
        notificacaoRepository.save(notificacao);

        Optional<Notificacao> encontrada = notificacaoRepository.findById(notificacao.getId());
        assertTrue(encontrada.isPresent());
        assertTrue(encontrada.get().isVisualizada());
    }
}
package com.example.fastpass.service;

import com.example.fastpass.model.Login;
import com.example.fastpass.model.Notificacao;
import com.example.fastpass.model.Usuario;
import com.example.fastpass.repository.UsuarioRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@ActiveProfiles("test")
class NotificacaoServiceIntegrationTest {

    @Autowired
    private NotificacaoService notificacaoService;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Test
    void deveCriarEMarcarNotificacaoComoLida() {
        Login login = new Login("carlosmatos", "senha123");
        Usuario usuario = usuarioRepository.save(
                new Usuario("Carlos Matos", "carlos@email.com", "11122233344", login));

        Notificacao criada = notificacaoService.criar(usuario, "Recarga confirmada.");
        assertFalse(criada.isVisualizada());

        Notificacao lida = notificacaoService.marcarComoLida(criada.getId());
        assertTrue(lida.isVisualizada());
    }
}

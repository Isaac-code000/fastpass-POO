package com.example.fastpass.service;

import com.example.fastpass.exception.NotificacaoNaoEncontradaException;
import com.example.fastpass.model.Notificacao;
import com.example.fastpass.model.Usuario;
import com.example.fastpass.repository.NotificacaoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NotificacaoService {

    private final NotificacaoRepository notificacaoRepository;

    public NotificacaoService(NotificacaoRepository notificacaoRepository) {
        this.notificacaoRepository = notificacaoRepository;
    }

    public Notificacao criar(Usuario usuario, String mensagem) {
        Notificacao notificacao = new Notificacao(mensagem, usuario);
        notificacao.enviar(); // marca a data de envio (ver Notificacao.java)
        return notificacaoRepository.save(notificacao);
    }

    public Notificacao marcarComoLida(Long id) {
        Notificacao notificacao = notificacaoRepository.findById(id)
                .orElseThrow(() -> new NotificacaoNaoEncontradaException(id));
        notificacao.marcarComoLida();
        return notificacaoRepository.save(notificacao);
    }

    public List<Notificacao> listarTodas() {
        return notificacaoRepository.findAll();
    }
}

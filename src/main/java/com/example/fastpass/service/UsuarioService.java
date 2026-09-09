package com.example.fastpass.service;

import com.example.fastpass.exception.ApelidoJaCadastradoException;
import com.example.fastpass.exception.UsuarioNaoEncontradoException;
import com.example.fastpass.model.Login;
import com.example.fastpass.model.Usuario;
import com.example.fastpass.repository.UsuarioRepository;
import org.springframework.stereotype.Service;

@Service
public class UsuarioService {

    private final UsuarioRepository usuarioRepository;

    public UsuarioService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public Usuario cadastrar(String nome, String email, String cpf, String apelido, String senha) {
        // Correção: Agora o banco faz a busca rápida e segura
        boolean apelidoExiste = usuarioRepository.findByLoginApelido(apelido).isPresent();

        if (apelidoExiste) {
            throw new ApelidoJaCadastradoException(apelido);
        }

        Login login = new Login(apelido, senha);
        Usuario usuario = new Usuario(nome, email, cpf, login);
        return usuarioRepository.save(usuario);
    }

    public Usuario buscarPorApelido(String apelido) {
        // Correção: Busca otimizada sem carregar toda a tabela na memória
        return usuarioRepository.findByLoginApelido(apelido)
                .orElseThrow(() -> new UsuarioNaoEncontradoException(apelido));
    }

    public Usuario buscarPorId(Long id) {
        return usuarioRepository.findById(id)
                .orElseThrow(() -> new UsuarioNaoEncontradoException(id));
    }
}

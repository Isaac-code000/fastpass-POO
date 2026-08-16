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
        boolean apelidoExiste = usuarioRepository.findAll().stream()
                .anyMatch(u -> u.getLogin().getApelido().equals(apelido));

        if (apelidoExiste) {
            throw new ApelidoJaCadastradoException(apelido);
        }

        Login login = new Login(apelido, senha);
        Usuario usuario = new Usuario(nome, email, cpf, login);
        return usuarioRepository.save(usuario);
    }

    public Usuario buscarPorApelido(String apelido) {
        return usuarioRepository.findAll().stream()
                .filter(u -> u.getLogin().getApelido().equals(apelido))
                .findFirst()
                .orElseThrow(() -> new UsuarioNaoEncontradoException(apelido));
    }
}

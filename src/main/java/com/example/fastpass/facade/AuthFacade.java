package com.example.fastpass.facade;

import com.example.fastpass.exception.CredenciaisInvalidasException;
import com.example.fastpass.exception.UsuarioNaoEncontradoException;
import com.example.fastpass.model.Usuario;
import com.example.fastpass.service.UsuarioService;
import org.springframework.stereotype.Component;

@Component
public class AuthFacade {

    private final UsuarioService usuarioService;

    public AuthFacade(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    /**
     * Ponto único que o Controller vai chamar para autenticar um usuário.
     * Ela esconde do Controller o "como" — que envolve buscar o usuário
     * (Service) e depois checar a senha (regra que mora dentro do Login).
     */
    public Usuario autenticar(String apelido, String senhaDigitada) {
        Usuario usuario;
        try {
            usuario = usuarioService.buscarPorApelido(apelido);
        } catch (UsuarioNaoEncontradoException e) {
            // Não expomos pro usuário final se o erro foi "apelido não existe"
            // ou "senha errada" — por segurança, a mensagem é sempre genérica.
            throw new CredenciaisInvalidasException();
        }

        boolean senhaCorreta = usuario.getLogin().validarSenha(senhaDigitada);
        if (!senhaCorreta) {
            throw new CredenciaisInvalidasException();
        }

        return usuario;
    }

    public Usuario cadastrar(String nome, String email, String cpf, String apelido, String senha) {
        return usuarioService.cadastrar(nome, email, cpf, apelido, senha);
    }
}

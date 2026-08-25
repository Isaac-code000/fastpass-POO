package com.example.fastpass.facade;

import com.example.fastpass.exception.CredenciaisInvalidasException;
import com.example.fastpass.exception.UsuarioNaoEncontradoException;
import com.example.fastpass.model.Passe;
import com.example.fastpass.model.StatusPasse;
import com.example.fastpass.model.TipoPasse;
import com.example.fastpass.model.Usuario;
import com.example.fastpass.repository.PasseRepository;
import com.example.fastpass.service.UsuarioService;
import org.springframework.stereotype.Component;

import java.time.LocalDate;

@Component
public class AuthFacade {

    private final UsuarioService usuarioService;
    private final PasseRepository passeRepository;

    public AuthFacade(UsuarioService usuarioService, PasseRepository passeRepository) {
        this.usuarioService = usuarioService;
        this.passeRepository = passeRepository;
    }

    public Usuario autenticar(String apelido, String senhaDigitada) {
        Usuario usuario;
        try {
            usuario = usuarioService.buscarPorApelido(apelido);
        } catch (UsuarioNaoEncontradoException e) {
            throw new CredenciaisInvalidasException();
        }

        boolean senhaCorreta = usuario.getLogin().validarSenha(senhaDigitada);
        if (!senhaCorreta) {
            throw new CredenciaisInvalidasException();
        }

        return usuario;
    }

    public Usuario cadastrar(String nome, String email, String cpf, String apelido, String senha) {
        Usuario usuario = usuarioService.cadastrar(nome, email, cpf, apelido, senha);

        // NOVO: todo usuário cadastrado já ganha um Passe padrão (tipo
        // COMUM, saldo zero, válido por 1 ano), automaticamente. Sem
        // isso, a Home do app nunca teria dado nenhum pra mostrar
        Passe passePadrao = new Passe(
                0.0,
                LocalDate.now().plusYears(1),
                StatusPasse.ATIVO,
                TipoPasse.COMUM,
                usuario
        );
        passeRepository.save(passePadrao);

        return usuario;
    }
}
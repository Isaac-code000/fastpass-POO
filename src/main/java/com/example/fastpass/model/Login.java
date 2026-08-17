package com.example.fastpass.model;

import com.example.fastpass.exception.LoginBloqueadoException;
import jakarta.persistence.*;

@Entity
public class Login {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String apelido;
    private String senha;
    private int tentativasFalhas;
    private boolean bloqueado;

    public Login() {}

    public Login(String apelido, String senha) {
        this.apelido = apelido;
        this.senha = senha;
        this.tentativasFalhas = 0;
        this.bloqueado = false;
    }
    public boolean validarSenha(String senhaDigitada) {
        if (this.bloqueado) {
            throw new LoginBloqueadoException(this.apelido);
        }

        boolean correta = this.senha.equals(senhaDigitada);

        if (correta) {
            this.tentativasFalhas = 0; // zera o contador em caso de sucesso
        } else {
            this.tentativasFalhas++;
            if (this.tentativasFalhas >= 5) {
                this.bloqueado = true;
            }
        }
        return correta;
    }

    public Long getId() { return id; }

    public String getApelido() { return apelido; }
    public void setApelido(String apelido) { this.apelido = apelido; }

    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }

    public int getTentativasFalhas() { return tentativasFalhas; }

    public boolean isBloqueado() { return bloqueado; }
}

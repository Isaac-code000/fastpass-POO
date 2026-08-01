package com.example.fastpass.model;
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

    // Construtor vazio: o Hibernate precisa um construtor sem argumentos
    // para conseguir instanciar a classe ao ler dados do banco.
    public Login() {}

    public Login(String apelido, String senha) {
        this.apelido = apelido;
        this.senha = senha;
        this.tentativasFalhas = 0;
        this.bloqueado = false;
    }

    // Getters e setters
    public Long getId() { return id; }

    public String getApelido() { return apelido; }
    public void setApelido(String apelido) { this.apelido = apelido; }

    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }

    public int getTentativasFalhas() { return tentativasFalhas; }
    public void setTentativasFalhas(int t) { this.tentativasFalhas = t; }

    public boolean isBloqueado() { return bloqueado; }
    public void setBloqueado(boolean bloqueado) { this.bloqueado = bloqueado; }

}

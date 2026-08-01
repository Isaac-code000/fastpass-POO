package com.example.fastpass.model;
import jakarta.persistence.*;

@Entity
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String nome;
    private String email;
    private String cpf;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "login_id")
    private Login login;

    public Usuario() {}

    public Usuario(String nome, String email, String cpf, Login login) {
        this.nome = nome;
        this.email = email;
        this.cpf = cpf;
        this.login = login;
    }

    public long getId() {
        return id;
    }
   public String getNome() {return nome;}
    public void  setNome(String nome) {this.nome = nome;}
    public String getEmail() {return email;}
    public void  setEmail(String email) {this.email = email;}
    public String getCpf() {return cpf;}
    public void setCpf(String cpf){this.cpf = cpf;}
    public Login getLogin() {return login;}
    public void setLogin(Login login) {this.login = login;}
}

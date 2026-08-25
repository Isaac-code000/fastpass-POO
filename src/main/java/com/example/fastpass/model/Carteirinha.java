package com.example.fastpass.model;

import java.time.LocalDate;
import jakarta.persistence.*;

@Entity
public class Carteirinha {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String instituicao;
	private LocalDate validade;
	private String matricula;
	private String curso;

	@ManyToOne
	@JoinColumn(name = "usuario_id")
	private Usuario usuario;

	public Carteirinha() {
	}

	public Carteirinha(String matricula, String instituicao, String curso, LocalDate validade, Usuario usuario) {
		this.matricula = matricula;
		this.instituicao = instituicao;
		this.curso = curso;
		this.validade = validade;
		this.usuario = usuario;
	}

	public boolean validar() {
		if (this.validade == null) {
			return false;
		}
		return !this.validade.isBefore(LocalDate.now());
	}

	public void renovar(LocalDate novaValidade) {
		this.validade = novaValidade;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public LocalDate getValidade() {
		return validade;
	}

	public void setValidade(LocalDate validade) {
		this.validade = validade;
	}

	public String getInstituicao() {
		return instituicao;
	}

	public void setInstituicao(String instituicao) {
		this.instituicao = instituicao;
	}

	public String getMatricula() {
		return matricula;
	}

	public void setMatricula(String matricula) {
		this.matricula = matricula;
	}

	public String getCurso() {
		return curso;
	}

	public void setCurso(String curso) {
		this.curso = curso;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
}
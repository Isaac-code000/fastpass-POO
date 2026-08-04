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

	// 1. CONSTRUTOR VAZIO
	public Carteirinha() {
	}

	// 2. CONSTRUTOR COM PARÂMETROS
	public Carteirinha(String matricula, String instituicao, LocalDate validade) {
		this.matricula = matricula;
		this.instituicao = instituicao;
		this.validade = validade;
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

	// Getters and Setters

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

}

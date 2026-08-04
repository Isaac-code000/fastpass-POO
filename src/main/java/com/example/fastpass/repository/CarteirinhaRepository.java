package com.example.fastpass.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.fastpass.model.Carteirinha;


@Repository
public interface CarteirinhaRepository extends JpaRepository<Carteirinha, Long> {

}
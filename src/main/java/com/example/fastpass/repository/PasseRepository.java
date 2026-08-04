package com.example.fastpass.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.fastpass.model.Passe; 

@Repository
public interface PasseRepository extends JpaRepository<Passe, Long> {

}
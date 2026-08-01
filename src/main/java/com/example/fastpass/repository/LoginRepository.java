package com.example.fastpass.repository;
import com.example.fastpass.model.Login;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LoginRepository extends JpaRepository<Login,Long> {
}

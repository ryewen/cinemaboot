package com.loststars.cinemaboot.field;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@MapperScan("com.loststars.cinemaboot.field.dao")
@EnableTransactionManagement
public class FieldApplication {

	public static void main(String[] args) {
		SpringApplication.run(FieldApplication.class, args);
	}
}

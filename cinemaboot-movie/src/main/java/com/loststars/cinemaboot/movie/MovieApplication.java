package com.loststars.cinemaboot.movie;

import com.alibaba.druid.pool.DruidDataSource;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@MapperScan("com.loststars.cinemaboot.movie.dao")
@EnableTransactionManagement
public class MovieApplication {

	public static void main(String[] args) {
		ConfigurableApplicationContext context = SpringApplication.run(MovieApplication.class, args);
	}
}

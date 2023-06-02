package com.example.springboot.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.batch.BatchClient;

@RestController
public class HelloController {

    @GetMapping("/")
    public String index() {
        BatchClient batchClient = BatchClient.builder()
                                             .region(Region.of("eu-west-1"))
                                             .build();

        return "Greetings from Spring Boot!";
    }
}

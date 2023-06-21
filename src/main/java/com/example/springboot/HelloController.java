package com.example.springboot.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.amazonaws.xray.interceptors.TracingInterceptor;
import software.amazon.awssdk.core.client.config.ClientOverrideConfiguration;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.batch.BatchClient;

@RestController
public class HelloController {

    @GetMapping("/")
    public String index() {
        BatchClient batchClient = BatchClient.builder()
                                             .region(Region.of("eu-west-1"))
                                             .overrideConfiguration(ClientOverrideConfiguration.builder()
                                                 .addExecutionInterceptor(new TracingInterceptor())
                                                 .build())
                                             .build();

        return "Greetings from Spring Boot!";
    }
}

package com.sg.interview_creation_portal;

import com.sg.interview_creation_portal.config.FileStorageProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties({
        FileStorageProperties.class
})
public class InterviewCreationPortalApplication {

    public static void main(String[] args) {
        SpringApplication.run(InterviewCreationPortalApplication.class, args);
    }

}

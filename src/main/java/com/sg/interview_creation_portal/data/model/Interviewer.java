package com.sg.interview_creation_portal.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.UniqueConstraint;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Interviewer {

    @Id
    @GeneratedValue
    private Long id;

    private String name;

    private String email;

    private String employeeCode;
}

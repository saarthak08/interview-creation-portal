package com.sg.interview_creation_portal.data.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Interview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String date;

    private Long startTiming;

    private Long endTiming;

    @ManyToOne
    @JoinColumn(name = "interviewee")
    private Interviewee interviewee;

    @ManyToOne
    @JoinColumn(name = "interviewer")
    private Interviewer interviewer;
}

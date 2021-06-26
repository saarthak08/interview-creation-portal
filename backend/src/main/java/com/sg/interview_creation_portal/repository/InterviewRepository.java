package com.sg.interview_creation_portal.repository;

import com.sg.interview_creation_portal.data.entity.Interview;
import com.sg.interview_creation_portal.data.entity.Interviewer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InterviewRepository extends JpaRepository<Interview, Long> {
    List<Interview> findByDateAndInterviewer(String date, Interviewer interviewer);
}

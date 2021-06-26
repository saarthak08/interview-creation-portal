package com.sg.interview_creation_portal.repository;

import com.sg.interview_creation_portal.data.entity.Interviewer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InterviewerRepository extends JpaRepository<Interviewer, Long> {
}

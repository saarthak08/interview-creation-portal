package com.sg.interview_creation_portal.repository;

import com.sg.interview_creation_portal.data.entity.Interviewee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IntervieweeRepository extends JpaRepository<Interviewee, Long> {
}

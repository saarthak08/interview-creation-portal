package com.sg.interview_creation_portal.config;

import com.sg.interview_creation_portal.data.builder.IntervieweeBuilder;
import com.sg.interview_creation_portal.data.builder.InterviewerBuilder;
import com.sg.interview_creation_portal.data.entity.Interviewee;
import com.sg.interview_creation_portal.data.entity.Interviewer;
import com.sg.interview_creation_portal.repository.IntervieweeRepository;
import com.sg.interview_creation_portal.repository.InterviewerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Component
public class InitialDataLoader implements
        ApplicationListener<ContextRefreshedEvent> {

    private final IntervieweeRepository intervieweeRepository;
    private final InterviewerRepository interviewerRepository;

    @Autowired
    public InitialDataLoader(IntervieweeRepository intervieweeRepository, InterviewerRepository interviewerRepository) {
        this.intervieweeRepository = intervieweeRepository;
        this.interviewerRepository = interviewerRepository;
    }

    @Override
    @Transactional
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {

        // Adding Interviewers

        List<Interviewer> interviewerList = new ArrayList<>();
        Interviewer interviewer = InterviewerBuilder.anInterviewer()
                .setName("Saarthak Gupta")
                .setEmail("saarthakgupta08@gmail.com")
                .setEmployeeCode("EMP-1")
                .build();
        interviewerList.add(interviewer);

        interviewer = InterviewerBuilder.anInterviewer()
                .setName("Abhilash Gupta")
                .setEmail("test2.com")
                .setEmployeeCode("EMP-2")
                .build();
        interviewerList.add(interviewer);


        //Adding Interviewees

        interviewerRepository.saveAll(interviewerList);

        List<Interviewee> interviewees = new ArrayList<>();
        Interviewee interviewee = IntervieweeBuilder.anInterviewee()
                .setName("Interviewee 1")
                .setEmail("saarthakgupta08@outlook.com")
                .build();
        interviewees.add(interviewee);

        interviewee = IntervieweeBuilder.anInterviewee()
                .setName("Interviewee 2")
                .setEmail("interviewee2@gmail.com")
                .build();
        interviewees.add(interviewee);

        interviewee = IntervieweeBuilder.anInterviewee()
                .setName("Interviewee 3")
                .setEmail("interviewee3@gmail.com")
                .build();
        interviewees.add(interviewee);

        interviewee = IntervieweeBuilder.anInterviewee()
                .setName("Interviewee 4")
                .setEmail("interviewee4@gmail.com")
                .build();
        interviewees.add(interviewee);

        interviewee = IntervieweeBuilder.anInterviewee()
                .setName("Interviewee 5")
                .setEmail("interviewee5@gmail.com")
                .build();
        interviewees.add(interviewee);

        interviewee = IntervieweeBuilder.anInterviewee()
                .setName("Interviewee 6")
                .setEmail("interviewee6@gmail.com")
                .build();
        interviewees.add(interviewee);

        interviewee = IntervieweeBuilder.anInterviewee()
                .setName("Interviewee 7")
                .setEmail("interviewee7@gmail.com")
                .build();
        interviewees.add(interviewee);

        interviewee = IntervieweeBuilder.anInterviewee()
                .setName("Interviewee 8")
                .setEmail("interviewee8@gmail.com")
                .build();
        interviewees.add(interviewee);

        intervieweeRepository.saveAll(interviewees);
    }
}

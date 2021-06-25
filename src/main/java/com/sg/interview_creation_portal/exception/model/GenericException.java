package com.sg.interview_creation_portal.exception.model;


import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class GenericException extends Exception {
    private String message;
    private ExceptionType exceptionType;

    public GenericException(String message, ExceptionType exceptionType) {
        super(message);
        this.message = message;
        this.exceptionType = exceptionType;
    }
}
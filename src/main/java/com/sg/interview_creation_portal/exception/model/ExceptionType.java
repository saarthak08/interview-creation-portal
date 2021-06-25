package com.sg.interview_creation_portal.exception.model;

import org.springframework.http.HttpStatus;

public enum ExceptionType {
    NOT_FOUND_EXCEPTION("NOT_FOUND", HttpStatus.NOT_FOUND),
    ALREADY_PRESENT("ALREADY_PRESENT", HttpStatus.ALREADY_REPORTED),
    INTERNAL_SERVER_ERROR("INTERNAL_SERVER_ERROR", HttpStatus.INTERNAL_SERVER_ERROR);

    private final String message;
    private final HttpStatus httpStatus;

    ExceptionType(String message, HttpStatus httpStatus) {
        this.message = message;
        this.httpStatus = httpStatus;
    }

    public String getMessage() {
        return this.message;
    }

    public HttpStatus getHttpStatus() {
        return this.httpStatus;
    }
}

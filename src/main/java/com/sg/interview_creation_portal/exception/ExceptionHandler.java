package com.sg.interview_creation_portal.exception;

import com.sg.interview_creation_portal.exception.model.ErrorResponse;
import com.sg.interview_creation_portal.exception.model.GenericException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;


@ControllerAdvice
public class ExceptionHandler extends ResponseEntityExceptionHandler {

    Logger logger = LoggerFactory.getLogger(ExceptionHandler.class);

    @org.springframework.web.bind.annotation.ExceptionHandler(value = Exception.class)
    public ResponseEntity<?> handleException(Exception ex) {
        logger.error(ex.getMessage());
        ErrorResponse response = new ErrorResponse("Server Error!", ex.getLocalizedMessage());
        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @org.springframework.web.bind.annotation.ExceptionHandler(value = GenericException.class)
    public ResponseEntity<?> handleGenericException(GenericException exception) {
        logger.error(exception.getMessage());
        ErrorResponse response = new ErrorResponse("Error! " + exception.getExceptionType().getMessage(),
                exception.getMessage());
        return new ResponseEntity<>(response, exception.getExceptionType().getHttpStatus());
    }

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex,
                                                                  HttpHeaders headers, HttpStatus status, WebRequest request) {
        StringBuilder details = new StringBuilder("");
        for (ObjectError error : ex.getBindingResult().getAllErrors()) {
            details.append(error.getDefaultMessage()).append(", ");
        }
        ErrorResponse error = new ErrorResponse("Error! Validation Failed", details.toString());
        logger.error(ex.getMessage());
        return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
    }
}
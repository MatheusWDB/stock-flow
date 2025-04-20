package br.com.hematsu.stock_flow.exceptions;

import java.time.Instant;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import br.com.hematsu.stock_flow.exceptions.movement.InsufficientStockException;
import br.com.hematsu.stock_flow.exceptions.movement.InvalidMovementTypeException;
import br.com.hematsu.stock_flow.exceptions.product.DuplicateProductCodeException;
import br.com.hematsu.stock_flow.exceptions.product.InvalidProductPriceException;
import br.com.hematsu.stock_flow.exceptions.product.ProductHasMovementsException;
import br.com.hematsu.stock_flow.exceptions.product.ProductNotFoundException;
import br.com.hematsu.stock_flow.exceptions.user.InvalidCredentialsException;
import br.com.hematsu.stock_flow.exceptions.user.UnauthorizedException;
import br.com.hematsu.stock_flow.exceptions.user.UserAlreadyExistsException;
import jakarta.servlet.http.HttpServletRequest;

@ControllerAdvice
public class ResourceExceptionHandler {

    @ExceptionHandler(InsufficientStockException.class)
    public ResponseEntity<StandardError> insufficientStockException(InsufficientStockException e,
            HttpServletRequest request) {
        String error = "UNPROCESSABLE ENTITY";
        HttpStatus status = HttpStatus.UNPROCESSABLE_ENTITY;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(),
                request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(InvalidMovementTypeException.class)
    public ResponseEntity<StandardError> invalidMovementTypeException(InvalidMovementTypeException e,
            HttpServletRequest request) {
        String error = "BAD REQUEST";
        HttpStatus status = HttpStatus.BAD_REQUEST;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(),
                request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(DuplicateProductCodeException.class)
    public ResponseEntity<StandardError> duplicateProductCodeException(DuplicateProductCodeException e,
            HttpServletRequest request) {
        String error = "CONFLICT";
        HttpStatus status = HttpStatus.CONFLICT;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(),
                request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(InvalidProductPriceException.class)
    public ResponseEntity<StandardError> invalidProductPriceException(InvalidProductPriceException e,
            HttpServletRequest request) {
        String error = "BAD REQUEST";
        HttpStatus status = HttpStatus.BAD_REQUEST;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(),
                request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(ProductHasMovementsException.class)
    public ResponseEntity<StandardError> productHasMovementsException(ProductHasMovementsException e,
            HttpServletRequest request) {
        String error = "CONFLICT";
        HttpStatus status = HttpStatus.CONFLICT;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(),
                request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(ProductNotFoundException.class)
    public ResponseEntity<StandardError> productNotFoundException(ProductNotFoundException e,
            HttpServletRequest request) {
        String error = "NOT FOUND";
        HttpStatus status = HttpStatus.NOT_FOUND;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(),
                request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(InvalidCredentialsException.class)
    public ResponseEntity<StandardError> invalidCredentialsException(InvalidCredentialsException e,
            HttpServletRequest request) {
        String error = "UNAUTHORIZED";
        HttpStatus status = HttpStatus.UNAUTHORIZED;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(),
                request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(UnauthorizedException.class)
    public ResponseEntity<StandardError> unauthorizedException(UnauthorizedException e,
            HttpServletRequest request) {
        String error = "UNAUTHORIZED";
        HttpStatus status = HttpStatus.UNAUTHORIZED;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(),
                request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }

    @ExceptionHandler(UserAlreadyExistsException.class)
    public ResponseEntity<StandardError> userAlreadyExistsException(UserAlreadyExistsException e,
            HttpServletRequest request) {
        String error = "CONFLICT";
        HttpStatus status = HttpStatus.CONFLICT;
        StandardError err = new StandardError(Instant.now(), status.value(), error, e.getMessage(),
                request.getRequestURI());
        return ResponseEntity.status(status).body(err);
    }
}

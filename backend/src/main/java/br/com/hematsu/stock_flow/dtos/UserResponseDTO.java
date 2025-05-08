package br.com.hematsu.stock_flow.dtos;

public record UserResponseDTO(String token, Long userId, String name, String username) {
}

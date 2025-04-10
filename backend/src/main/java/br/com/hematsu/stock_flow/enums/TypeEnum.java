package br.com.hematsu.stock_flow.enums;

public enum TypeEnum {
    OUT(0),
    IN(1);

    private int code;

    private TypeEnum(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static TypeEnum valueOf(int code) {
        for (TypeEnum value : TypeEnum.values()) {
            if (value.getCode() == code)
                return value;
        }
        throw new IllegalArgumentException("Tipo inválido");
    }

}

package io.dummyapi;

public enum ConfigService {
    DUMMY_API_BASE_URL("https://dummyapi.io/data/v1/");

    private final String value;

    public String getValue() {
        return value;
    }

    ConfigService(String value) {
        this.value = value;
    }
}

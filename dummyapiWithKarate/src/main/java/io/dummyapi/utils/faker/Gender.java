package io.dummyapi.utils.faker;

public enum Gender {
    FEMALE("female"),
    MALE("male"),
    OTHER("other"),
    EMPTY("");

    private final String value;

    Gender(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}

package io.dummyapi.utils.faker;

public enum UserTitle {
    MR("mr"),
    MS("ms"),
    MRS("mrs"),
    MISS("miss"),
    DR("dr"),
    EMPTY("");

    private final String value;

    UserTitle(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}

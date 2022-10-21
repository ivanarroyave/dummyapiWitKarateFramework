package io.dummyapi.utils.faker;

import com.github.javafaker.Faker;
import java.util.Locale;
import java.util.Random;

public class PeopleFaker {

    private PeopleFaker() {
    }

    public static Faker peopleFaker(String language, String country){
        return   Faker.instance(
                new Locale(language, country),
                new Random()
        );
    }
}

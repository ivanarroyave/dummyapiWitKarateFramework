package io.dummyapi.utils.faker;

import com.github.javafaker.Faker;
import io.dummyapi.models.user.create.UserBody;

import static io.dummyapi.utils.faker.Gender.MALE;
import static io.dummyapi.utils.faker.PeopleFaker.peopleFaker;
import static io.dummyapi.utils.faker.UserTitle.MR;

public class UserFaker {

    public static final String SPANISH_CODE_LANGUAGE = "en";
    public static final String COUNTRY_CODE = "US";
    public static final String EMAIL_DOMAIN = "@sofka.com";
    private static final String EMPTY_STRING = "";
    private static final String SPACE_STRING = " ";

    private UserFaker() {
    }

    public static UserBody generateUser(String language, String country, String emailDomain){
        Faker faker = peopleFaker(language, country);

        UserBody user = new UserBody();
        user.setTitle(MR.getValue());
        user.setFirstName(faker.name().firstName());
        user.setLastName(faker.name().lastName());
        user.setGender(MALE.getValue());
        user.setEmail(faker.name().username().concat(emailDomain).replace(SPACE_STRING, EMPTY_STRING));
        user.setPhone(faker.phoneNumber().cellPhone());

        return user;
    }

    public static UserBody generateUserWithoutData(){
        UserBody user = new UserBody();
        user.setTitle(EMPTY_STRING);
        user.setFirstName(EMPTY_STRING);
        user.setLastName(EMPTY_STRING);
        user.setGender(EMPTY_STRING);
        user.setEmail(EMPTY_STRING);
        user.setPhone(EMPTY_STRING);

        return user;
    }
}

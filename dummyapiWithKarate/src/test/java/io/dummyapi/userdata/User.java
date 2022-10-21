package io.dummyapi.userdata;

import io.dummyapi.models.user.create.UserBody;

import static io.dummyapi.utils.Json.generateJson;
import static io.dummyapi.utils.faker.UserFaker.*;
import static io.dummyapi.utils.faker.UserFaker.EMAIL_DOMAIN;

public class User {
    public static String generateBodyForCreateUser(){
        return generateJson(userBody());
    }

    public static String generateBodyForCreateUser(UserBody userBody){
        return generateJson(userBody);
    }

    public static UserBody userBody(){
        return generateUser(SPANISH_CODE_LANGUAGE, COUNTRY_CODE, EMAIL_DOMAIN);
    }

    public static UserBody emptyUserBody(){
        return new UserBody();
    }
}

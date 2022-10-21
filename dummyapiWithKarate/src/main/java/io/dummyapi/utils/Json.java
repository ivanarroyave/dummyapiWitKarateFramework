package io.dummyapi.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class Json {

    private Json() {
    }

    public static <T> String generateJson(T object){

        Gson gson = new GsonBuilder()
                .setPrettyPrinting()
                .create();

        return gson.toJson(object);

    }
}

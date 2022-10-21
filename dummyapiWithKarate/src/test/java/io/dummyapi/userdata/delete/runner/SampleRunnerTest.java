package io.dummyapi.userdata.delete.runner;

import com.intuit.karate.junit5.Karate;

public class SampleRunnerTest {
    @Karate.Test
    Karate test(){
        return Karate
                .run("classpath:io/dummyapi/userdata/delete/delete-user.feature")
                .tags("~@ignore")
                .karateEnv("QA");
    }
}

package io.dummyapi.userdata.update.runner;

import com.intuit.karate.junit5.Karate;

public class SampleRunnerTest {
    @Karate.Test
    Karate test(){
        return Karate
                .run("classpath:io/dummyapi/userdata/update/update-user.feature")
                .tags("~@ignore")
                .karateEnv("QA");
    }
}

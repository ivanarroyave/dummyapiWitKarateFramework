package io.dummyapi.userdata.search.runner;

import com.intuit.karate.junit5.Karate;

public class SampleRunnerTest {
    @Karate.Test
    Karate test(){
        return Karate
                .run("classpath:io/dummyapi/userdata/search/")
                .tags("~@ignore")
                .karateEnv("QA");
    }
}

package io.dummyapi.runners;

import com.intuit.karate.junit5.Karate;

public class SampleRunnerTest {
    @Karate.Test
    Karate test(){
        return Karate
                .run("classpath:io/dummyapi/userdata/")
                .relativeTo(this.getClass())
                .tags("~@ignore")
                .karateEnv("QA");
    }
}

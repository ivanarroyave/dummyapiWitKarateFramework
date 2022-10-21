package io.dummyapi.userdata.create.runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static io.dummyapi.utils.CucumberReportForKarate.generateCucumberReport;
import static org.junit.jupiter.api.Assertions.assertEquals;

class ParallelRunnerTest {
    @Test
    void parallelRunnerTest(){
        Results results = Runner
                .path("classpath:io/dummyapi/userdata/create/create-user.feature")
                .tags("~@ignore")
                .relativeTo(getClass())
                .outputCucumberJson(true)
                .karateEnv("QA")
                .parallel(Runtime.getRuntime().availableProcessors());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());

        generateCucumberReport(results.getReportDir());
    }
}

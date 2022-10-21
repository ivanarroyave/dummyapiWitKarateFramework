package io.dummyapi.runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static io.dummyapi.utils.CucumberReportForKarate.generateCucumberReport;
import static org.junit.jupiter.api.Assertions.assertEquals;

class ParallelRunnerTest {
    @Test
    void parallelRunnerTest(){
        Results results = Runner
                .path("classpath:io/dummyapi/userdata/")
                .tags("~@ignore")
                .relativeTo(getClass())
                .outputCucumberJson(true)
                .karateEnv("QA")
                .parallel(Runtime.getRuntime().availableProcessors());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());

        generateCucumberReport(results.getReportDir());
    }
}

pipeline {
    agent any
	
	tools { 
        gradle 'Gradle 6.9.3' 
    }
	
	options {
		// Keep the 10 most recent builds
		buildDiscarder(logRotator(numToKeepStr:'3'))
		skipStagesAfterUnstable()
	}
	
    stages {
        stage("Test") {
            steps {		
				dir("${env.WORKSPACE}/dummyapiWithKarate"){
					
					sh "gradle clean build -x test"
					
					sh "gradle test --tests *runners.ParallelRunnerTest*"
					
					publishHTML(target: [
						reportName : 'Cucumber with Karate report',
						reportDir:   'dummyapiWitKarate/build/cucumber-html-reports',
						reportFiles: 'overview-features.html',
						keepAll:     true,
						alwaysLinkToLastBuild: true,
						allowMissing: false
					])
				}
			}
        }
    }
}

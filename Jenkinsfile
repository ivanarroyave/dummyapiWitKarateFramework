pipeline {
    agent any
	
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
						reportName : 'Serenity bdd report',
						reportDir:   'target/site/serenity',
						reportFiles: 'index.html',
						keepAll:     true,
						alwaysLinkToLastBuild: true,
						allowMissing: false
					])
				}
			}
        }
    }
}

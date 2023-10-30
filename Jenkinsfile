pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    def mavenHome = tool name: 'Maven', type: 'hudson.tasks.Maven$MavenInstallation'
                    if (isUnix()) {
                        sh "${mavenHome}/bin/mvn clean install"
                    } else {
                        bat "\"${mavenHome}\\bin\\mvn\" clean install"
                    }
                }
            }
        }
    }
}

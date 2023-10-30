pipeline {
    agent any

   triggers {
          pollSCM('*/5 * * * *') // Poll every 10 minutes
      }

    stages {
      stage('Build') {
            when {
                // Define when this stage should run
                expression { currentBuild.description == "Main branch changes detected" }
            }
            steps {
                script {
                    script {
                        def mavenHome = tool name: 'Maven', type: 'hudson.tasks.Maven$MavenInstallation'
                            if (isUnix()) {
                                sh "${mavenHome}/bin/mvn clean install"
                                 } else {
                                            bat "\"${mavenHome}\\bin\\mvn\" clean install"
                                        }
                                    }
                    echo "Building for main branch"
                }
            }
        }
    }
}

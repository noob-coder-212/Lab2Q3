pipeline {
    agent any

   triggers {
          pollSCM('*/10 * * * *') // Poll every 10 minutes
      }

    stages {
        stage('Check for Changes') {
            steps {
                script {
                    // Detect changes in the main branch
                    def changeset = currentBuild.changeSets.find { it.branch == 'origin/master' }
                    if (changeset) {
                        echo "Changes detected in main branch. Triggering build."
                        currentBuild.description = "Main branch changes detected"
                    } else {
                        echo "No changes detected. Skipping build."
                        currentBuild.result = 'ABORTED'
                        error("No changes detected.")
                    }
                }
            }
        }

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

pipeline {
    agent any

   triggers {
          pollSCM('*/10 * * * *') // Poll every 10 minutes
      }

    stages {
        stage('Check for Changes') {
                    steps {
                        script {
                            def changesetList = currentBuild.changeSets
                            def changesDetected = false

                            for (def changeset : changesetList) {
                                if (changeset.items.any { it.branch == 'origin/main' }) {
                                    changesDetected = true
                                    break
                                }
                            }

                            if (changesDetected) {
                                echo "Changes detected in main branch. Triggering build."
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

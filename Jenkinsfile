pipeline {
    agent any

    stages {
        stage('Check for Changes') {
            steps {
                script {
                    if (changeset = currentBuild.changeSets.find { it.branch == 'origin/main' }) {
                        echo "Changes detected in main branch. Triggering build."
                    } else if (env.CHANGE_TARGET == 'master') {
                        echo "Merge request to main branch detected. Triggering build."
                    } else {
                        echo "No changes or merge requests detected. Skipping build."
                        currentBuild.result = 'ABORTED'
                        error("No changes or merge requests detected.")
                    }
                }
            }
        }

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

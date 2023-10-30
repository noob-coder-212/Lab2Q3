pipeline {
    agent any

    stages {
        stage('Check for Changes') {
            steps {
                script {
                    def changeset = currentBuild.changeSets[0] // Assuming only one change set is needed

                    if (changeset && changeset.target.matches('refs/heads/main')) {
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

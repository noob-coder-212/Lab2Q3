pipeline {
    agent any

    environment {
                    // Define your Docker Hub credentials
                    DOCKER_HUB_CREDENTIALS = credentials('docker-token')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Add Docker Hub Credentials') {

            steps {
                script {
                    // Authenticate with Docker Hub
                    withDockerServer([credentialsId: DOCKER_HUB_CREDENTIALS]) {
                        sh 'echo "Docker Hub credentials added."'
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
               sh 'docker build -t mercer212/lab3:latest .'
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    // Authenticate with Docker Hub


                    withDockerServer([credentialsId: DOCKER_HUB_CREDENTIALS]) {
                        sh 'echo "Docker logged in."'
                    }
                }
            }
        }

        stage('Docker Push') {
            steps {
               sh 'docker push mercer212/lab3:latest'
            }
        }
    }

    post {
        always {
            // Cleanup: Log out from Docker
            script {
                withDockerServer([credentialsId: DOCKER_HUB_CREDENTIALS]) {
                    sh 'docker logout'
                }
            }
        }
    }
}

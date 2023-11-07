pipeline {
    agent any

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
            environment {
                // Define your Docker Hub credentials
                DOCKER_HUB_CREDENTIALS = credentials('my-docker-hub-credentials')
            }
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
                sh 'docker build -t devopslab2q3:v1.0 .'
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
                sh 'docker push devopslab2q3:v1.0'
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

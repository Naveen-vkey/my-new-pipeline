pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'naveen429/vk-registry:jenkins'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/Naveen-vkey/my-new-pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push to Docker Registry') {
            steps {
                script {
                    // Login to Docker Registry
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "echo \"\$DOCKER_PASSWORD\" | docker login -u \"\$DOCKER_USERNAME\" --password-stdin"
                    }
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Command to deploy the Docker image to Kubernetes
                    sh "kubectl apply -f deployment.yaml"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}

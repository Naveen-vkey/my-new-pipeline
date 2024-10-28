pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Clone the repository
                git url: 'https://github.com/Naveen-vkey/my-new-pipeline.git', branch: 'main' // or the specific branch you need
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile in the repo
                sh 'docker build -t <registry-url>/myapp:latest .'
            }
        }

        stage('Push to Docker Registry') {
            steps {
                script {
                    // Login to the Docker registry
                    withCredentials([usernamePassword(credentialsId: 'docker-registry-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD <registry-url>'
                    }
                    // Push the Docker image
                    sh 'docker push <registry-url>/myapp:latest'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Update the Kubernetes deployment
                sh 'kubectl set image deployment/myapp-deployment myapp=<registry-url>/myapp:latest'
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}

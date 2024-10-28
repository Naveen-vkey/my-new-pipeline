pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Clone the repository
                git url: 'https://github.com/Naveen-vkey/my-new-pipeline.git', branch: 'master' // or the specific branch you need
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the specified repository name
                sh 'docker build -t naveen429/naveen:tagname .'
            }
        }

        stage('Push to Docker Registry') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-registry-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        // Log in to the Docker registry
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    }
                    // Push the Docker image to the registry
                    sh 'docker push naveen429/naveen:tagname'
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

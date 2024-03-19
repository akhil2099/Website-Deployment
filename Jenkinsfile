pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "my-website"
        GITHUB_REPO_URL = "https://github.com/techvantageai/Cloud-Deployment-Intern.git"
        GITHUB_BRANCH = "main"
        GITHUB_CREDENTIALS_ID = "Akhil-Techvantage"
        DOCKER_HUB_CREDENTIALS_ID = "docker-credentials-id"
        SSH_CREDENTIALS_ID = "5190b38c-5c42-450c-87f2-016f0c7921a8"
    }

    stages {
        stage('Clone GitHub Repository') {
            steps {
                script {
                    git credentialsId: "${GITHUB_CREDENTIALS_ID}", url: "${GITHUB_REPO_URL}", branch: "${GITHUB_BRANCH}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $DOCKER_IMAGE ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([
                        usernamePassword(credentialsId: "${DOCKER_HUB_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')
                    ]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                        sh "docker tag $DOCKER_IMAGE $DOCKER_USERNAME/$DOCKER_IMAGE"
                        sh "docker push $DOCKER_USERNAME/$DOCKER_IMAGE"
                    }
                }
            }
        }

        stage('Connect to Server and Execute Commands') {
            steps {
                script {
                    sshagent(['5190b38c-5c42-450c-87f2-016f0c7921a8']) {
                        sh '''
                            ssh -o StrictHostKeyChecking=no ubuntu@13.232.84.146 "docker pull akhil2099/my-website:latest"
                            ssh -o StrictHostKeyChecking=no ubuntu@13.232.84.146 "docker run -d -p 80:80 -p 443:443 akhil2099/my-website:latest"
                        '''
                    }
                }
            }
        }
    }
}

pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'olyfaneva/front-end'
        DOCKER_TAG = 'latest'
        REPO_URL = 'https://github.com/OlyFaneva/testcicdnuxt.git'
        SSH_CREDENTIALS = credentials('vps')
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    echo "Cloning repository: ${REPO_URL}"
                    git url: "${REPO_URL}", branch: 'main'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    sh '''
                        docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                    '''
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "Pushing Docker image to Docker Hub"
                    withDockerRegistry([credentialsId: 'docker', url: 'https://index.docker.io/v1/']) {
                        sh '''
                            docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                        '''
                    }
                }
            }
        }

        stage('Deploy to VPS') {
            steps {
                script {
                    echo 'Deploying to VPS'
                    sh '''
                        sshpass -p "${SSH_CREDENTIALS_PSW}" ssh -o StrictHostKeyChecking=no ${SSH_CREDENTIALS_USR}@89.116.111.200 << EOF
                        docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}
                        docker stop front-end || true
                        docker rm front-end || true
                        docker run -d --name front-end -p 8080:3002 ${DOCKER_IMAGE}:${DOCKER_TAG}
EOF
                    '''
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                script {
                    echo "Running Ansible playbook"
                    sh '''
                        ansible-playbook -i hosts.ini deploy.yml -vvv
                    '''
                }
            }
        }
    }
}
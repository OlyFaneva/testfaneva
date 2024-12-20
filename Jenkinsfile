pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'olyfaneva/front-test'
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

        stage('Scan Docker Image') {
            steps {
                script {
                    echo 'Scanning Docker image for vulnerabilities'
                    sh '''
                trivy image ${DOCKER_IMAGE}:${DOCKER_TAG} || exit 1
            '''
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo 'Pushing Docker image to Docker Hub'
                    withDockerRegistry([credentialsId: 'docker', url: 'https://index.docker.io/v1/']) {
                        sh '''
                            docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                        '''
                    }
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                script {
                    echo 'Running Ansible playbook'
                    sh '''
                        ansible-playbook -i hosts.ini deploy.yml -vvv
                    '''
                }
            }
        }
    }
}

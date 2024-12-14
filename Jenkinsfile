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

        stage('Install Dependencies and Test') {
            steps {
                script {
                    echo "Installing dependencies and running tests"
                    // Affiche le contenu du répertoire pour vérifier la présence de package.json
                    sh 'ls -la'

                    // Installer les dépendances et exécuter les tests
                    sh '''
                        docker run --rm -v $PWD:/app -w /app node:18-alpine sh -c "
                            if [ -f package.json ]; then
                                yarn install &&
                                yarn test
                            else
                                echo 'Error: package.json not found' && exit 1
                            fi
                        "
                    '''
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

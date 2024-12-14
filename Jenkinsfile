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

        stage('Check Repository Contents') {  
            steps {  
                script {  
                    echo 'Checking repository contents after cloning:'  
                    sh 'ls -la' // Lister tous les fichiers  
                    sh 'cat package.json || echo "package.json not found"' // Vérifie la présence de package.json  
                }  
            }  
        }  

        stage('Install Dependencies and Test') {  
            steps {  
                script {  
                    echo 'Installing dependencies and running tests'  

                    // Lancer le conteneur Node.js avec un utilisateur approprié  
                    sh '''  
                    docker run --rm -v ${WORKSPACE}:/app -w /app --user node node:18-alpine sh -c "  
                        echo 'Contents of /app:' &&  
                        ls -la /app &&  
                        ls -la /app/package.json &&  // Vérifie les permissions de package.json  
                        yarn install &&  
                        yarn test  
                    "  
                    '''  
                }  
            }  
        }  

        stage('Build Docker Image') {  
            steps {  
                script {  
                    echo "Building Docker image: ${DOCKER_IMAGE}:${DOCKER_TAG}"  
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."  
                }  
            }  
        }  

        stage('Scan Docker Image') {  
            steps {  
                script {  
                    echo 'Scanning Docker image for vulnerabilities'  
                    sh "trivy image ${DOCKER_IMAGE}:${DOCKER_TAG} || exit 1"  
                }  
            }  
        }  

        stage('Push to Docker Hub') {  
            steps {  
                script {  
                    echo 'Pushing Docker image to Docker Hub'  
                    withDockerRegistry([credentialsId: 'docker', url: 'https://index.docker.io/v1/']) {  
                        sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"  
                    }  
                }  
            }  
        }  

        stage('Run Ansible Playbook') {  
            steps {  
                script {  
                    echo 'Running Ansible playbook'  
                    sh 'ansible-playbook -i hosts.ini deploy.yml -vvv'  
                }  
            }  
        }  
    }  
}
pipeline {
    agent any
    stages{
        stage('Clone git repo'){
            steps{
                git branch: 'main', url: 'https://github.com/saifdp/streak-task.git'
            }
        }

        stage('Build Docker image'){
            steps{
                script{
                    dockerImage = docker.build("heysaif/streak-img")
                }
            }
        }

        

        stage('Push to dockerhub'){
            steps{
                script{
                    docker.withRegistry('https://registry.hub.docker.com/', 'dockerhub-credentials') {
                        dockerImage.push('latest')
                    }
                }
            }
        }
        
        stage('Run container'){
            steps{
                script{
                    sh 'docker run -d -p 5000:5000 --name flask-app heysaif/streak-img'
                }
            }
        }

        
        stage('Check Container Status') {
            steps{
                script{
                    sh 'docker ps -a'
                    sh 'docker logs flask-app'
                }
            }
        }


        

        stage('Test app') {
            steps{
                script{
                    sh 'sleep 10' 
                    sh 'curl -f http://localhost:5000'
                }
            }
        }

    }

    post {
        always{
            echo 'Cleaning up'
            sh 'docker stop flask-app || true && docker rm flask-app || true'
        }
    }
}

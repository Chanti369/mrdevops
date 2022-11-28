pipeline{
    agent any
    tools{
        maven 'MAVEN'
    }
    stages{
        stage('gIt checkout'){
            steps{
                script{
                    git branch: 'main', url: 'https://github.com/Chanti369/mrdevops.git'
                }
            }
        }
        stage('sonar static code'){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar') {
                        sh 'mvn clean package sonar:sonar'
                    }    
                }
            }
        }
        stage('quality gate'){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar'
                }
            }
        }
    }
}
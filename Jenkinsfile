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
        stage('nexus'){
            steps{
                script{
                    nexusArtifactUploader artifacts: [[artifactId: 'devops-integration', classifier: '', file: 'target/devops-integration.jar', type: 'jar']], credentialsId: 'nexus', groupId: 'com.javatechie', nexusUrl: '65.0.80.94:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'demoapp-snapshot', version: '0.0.1-SNAPSHOT'
                }
            }
        }
    }
}
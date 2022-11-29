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
                    withSonarQubeEnv(credentialsId: 'sonar1') {
                        sh 'mvn clean package sonar:sonar'
                    }    
                }
            }
        }
        stage('quality gate'){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar1'
                }
            }
        }
        stage('nexus'){
            steps{
                script{
                    nexusArtifactUploader artifacts: [[artifactId: 'devops-integration', classifier: '', file: 'target/devops-integration.jar', type: 'jar']], credentialsId: 'nexus', groupId: 'com.javatechie', nexusUrl: '65.2.30.12:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'demoapp-snapshot', version: '1.0.0-SNAPSHOT'
                }
            }
        }
        stage('docker image'){
            steps{
                script{
                    sh 'docker build -t $JOB_NAME:v1.$BUILD_ID .'
                    sh 'docker tag $JOB_NAME:v1.$BUILD_ID 7995323158/$JOB_NAME:v1.$BUILD_ID'
                    sh 'docker tag $JOB_NAME:v1.$BUILD_ID 7995323158/$JOB_NAME:latest'
                }
            }
        }
        stage('push image'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'docker_hub', variable: 'docker_hub_cred')]) {
                        sh 'docker login -u 7995323158 -p ${docker_hub_cred}'
                        sh 'docker push 7995323158/$JOB_NAME:v1.$BUILD_ID'
                        sh 'docker push 7995323158/$JOB_NAME:latest'
                    }    
                }
            }
        }
    }
    post {
		always {
			mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "adityakumarreddy298@gmail.com";  
		}
	}
}
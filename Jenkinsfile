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
                    withSonarQubeEnv(credentialsId: 'sona') {
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
    post {
		always {
			mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "adityakumarreddy298@gmail.com";  
		}
	}
}
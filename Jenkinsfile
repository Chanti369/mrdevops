pipeline{
    agent any
    stages{
        stage('gIt checkout'){
            steps{
                script{
                    git branch: 'main', url: 'https://github.com/Chanti369/mrdevops.git'
                }
            }
        }
    }
}
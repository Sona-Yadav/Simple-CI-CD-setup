pipeline {
    agent any
    
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/Sona-Yadav/simplehelloworld.git'
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building...'
                // Add your build commands here
            }
        }
        
        stage('Deploy to AWS') {
            steps {
                echo 'Deploying to AWS...'
                // Add your deployment commands here
            }
        }
    }
}

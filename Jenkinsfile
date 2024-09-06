pipeline {
    agent any
    
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Sona-Yadav/simplehelloworld.git'
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

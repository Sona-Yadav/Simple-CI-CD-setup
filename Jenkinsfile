pipeline {
    agent any
    
    environment {
        // Define any environment variables you need, such as AWS credentials or S3 bucket information
        AWS_REGION = 'ap-south-1'  // Adjust to your desired AWS region
        APPLICATION_NAME = 'jenkin-CICD'  // The name of your CodeDeploy application
        DEPLOYMENT_GROUP_NAME = 'jenkins-dg'  // The name of your CodeDeploy deployment group
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the code from the GitHub repository
                git branch: 'master', url: 'https://github.com/Sona-Yadav/simplehelloworld.git'
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building...'
                // Add your build commands here (e.g., building artifacts, running tests)
                // Example for Node.js: sh 'npm install && npm run build'
            }
        }
        
        stage('Deploy to AWS') {
            steps {
                echo 'Deploying to AWS...'
                
                // Add commands to trigger AWS CodeDeploy deployment
                // This assumes you are using the AWS CodeDeploy Jenkins plugin

                step([
                    $class: 'AWSCodeDeployPublisher',
                    applicationName: "${APPLICATION_NAME}",  // The name of your CodeDeploy application
                    deploymentGroupName: "${DEPLOYMENT_GROUP_NAME}",  // The name of your CodeDeploy deployment group
                    s3bucket: '',  // Optionally, specify an S3 bucket if you are using one for your deployment artifacts
                    s3prefix: '',  // Optionally, specify an S3 prefix if using one
                    deploymentRevisionLocation: [
                        revisionType: 'Blue/green',  // You can use 'S3' if your artifacts are in an S3 bucket
                        repositoryName: 'Sona-Yadav/simplehelloworld',
                        commitId: 'master'  // You can use a specific commit ID or branch
                    ]
                ])
            }
        }
    }
}

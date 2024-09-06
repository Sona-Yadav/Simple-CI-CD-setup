// pipeline {
//     agent any
    
//     environment {
//         AWS_REGION = 'ap-south-1'
//         APPLICATION_NAME = 'jenkin-CICD'
//         DEPLOYMENT_GROUP_NAME = 'jenkins-dg'
//     }
    
//     stages {
//         stage('Checkout Code') {
//             steps {
//                 // Checkout the code from GitHub
//                 git branch: 'master', url: 'https://github.com/Sona-Yadav/simplehelloworld.git'
//             }
//         }
        
//         stage('Build') {
//             steps {
//                 echo 'Building...'
//                 // Add your build commands here
//                 // Example for a Node.js project: sh 'npm install && npm run build'
//                 // You can archive build artifacts if needed, like war or zip files.
//             }
//         }
        
//         stage('Package') {
//             steps {
//                 echo 'Packaging...'
//                 // Archive or zip the application files to prepare for deployment.
//                 sh 'zip -r app.zip *'  // Example: create a zip file of your app.
//             }
//         }
        
//         stage('Deploy to AWS') {
//             steps {
//                 echo 'Deploying to AWS CodeDeploy...'
                
//                 // Trigger AWS CodeDeploy using the AWS CodeDeploy plugin
//                 step([
//                     $class: 'AWSCodeDeployPublisher',
//                     applicationName: "${APPLICATION_NAME}",
//                     deploymentGroupName: "${DEPLOYMENT_GROUP_NAME}",
//                     deploymentRevisionLocation: [
//                         revisionType: 'GitHub',  // Use GitHub as the source of your code
//                         repositoryName: 'Sona-Yadav/simplehelloworld',
//                         commitId: 'master'  // Specify the branch or commit ID
//                     ]
//                 ])
//             }
//         }
//     }
// }
pipeline {
    agent any

    environment {
        // Define your environment variables here if needed
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the code from the Git repository
                git url: 'https://github.com/Sona-Yadav/simplehelloworld.git', branch: 'master', credentialsId: 'github-credential'
            }
        }

        stage('Build') {
            steps {
                echo 'Building...'
                // Insert your build commands here (e.g., Maven, Gradle, etc.)
            }
        }

        stage('Deploy to AWS') {
            steps {
                echo 'Deploying to AWS...'
                script {
                    awsCodeDeploy(
                        applicationName: 'jenkin-CICD',
                        deploymentGroupName: 'jenkins-dg',
                        deploymentRevisionLocation: [
                            revisionType: 'GitHub',
                            repositoryName: 'Sona-Yadav/simplehelloworld',
                            commitId: 'b9994d63371db899759c294883f98ad9caf8cc34'
                        ],
                        region: 'ap-south-1' // Ensure the correct AWS region
                    )
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Add any cleanup steps you need here
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}

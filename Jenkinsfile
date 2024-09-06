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
        AWS_REGION = 'ap-south-1'
        APPLICATION_NAME = 'jenkin-CICD'
        DEPLOYMENT_GROUP_NAME = 'jenkins-dg'
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')  // AWS credentials stored in Jenkins Credentials
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')  // AWS credentials stored in Jenkins Credentials
    }
    
    parameters {
        string(name: 'BRANCH', defaultValue: 'master', description: 'Branch to build')
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Checking out code from branch: ${params.BRANCH}"
                // Checkout the code from the public GitHub repository (no credentials required)
                git branch: "${params.BRANCH}", url: 'https://github.com/Sona-Yadav/simplehelloworld.git'
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building...'
                // Add your build commands here, e.g., for a Node.js project
                // Example: sh 'npm install && npm run build'
            }
        }
        
        stage('Package') {
            steps {
                echo 'Packaging...'
                // Archive or zip the application files to prepare for deployment
                sh 'zip -r app.zip *'
                archiveArtifacts artifacts: 'app.zip', allowEmptyArchive: false
            }
        }
        
        stage('Deploy to AWS') {
            steps {
                echo 'Deploying to AWS CodeDeploy...'
                echo "Application: ${APPLICATION_NAME}, Deployment Group: ${DEPLOYMENT_GROUP_NAME}"

                // Trigger AWS CodeDeploy using the AWS CodeDeploy plugin
                step([
                    $class: 'AWSCodeDeployPublisher',
                    applicationName: "${APPLICATION_NAME}",
                    deploymentGroupName: "${DEPLOYMENT_GROUP_NAME}",
                    deploymentRevisionLocation: [
                        revisionType: 'GitHub',  // Use GitHub as the source of your code
                        repositoryName: 'Sona-Yadav/simplehelloworld',
                        commitId: 'master'  // Specify the branch or commit ID
                    ]
                ])
            }
        }

        stage('Verify Deployment') {
            steps {
                echo 'Verifying deployment...'
                // Add a command to verify deployment status using AWS CLI or SDK
                // Example: sh 'aws deploy get-deployment --deployment-id <deployment-id>'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline succeeded!'
            // Optional: Add success notifications here
        }
        failure {
            echo 'Pipeline failed!'
            // Optional: Add failure notifications here (e.g., email, Slack)
        }
    }
}

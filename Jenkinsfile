// pipeline {
//     agent any
    
//     environment {
//         AWS_REGION = 'ap-south-1'
//         AWS_CREDENTIALS = 'aws-credential'
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
        S3_BUCKET = 'jenkin-serve'          // Replace with your actual S3 bucket name
        APPLICATION_NAME = 'jenkin-CICD''    // Replace with your actual CodeDeploy application name
        DEPLOYMENT_GROUP = 'jenkins-dg'  // Replace with your actual CodeDeploy deployment group name
        AWS_REGION = 'ap-south-1'                          // Replace with your AWS region (e.g., us-east-1)
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Replace with your actual GitHub repository URL
                git 'https://github.com/Sona-Yadav/simplehelloworld.git'
            }
        }

        stage('Package Application') {
            steps {
                sh 'zip -r my_flask_app.zip *'
            }
        }

        stage('Upload to S3') {
            steps {
                // Ensure the AWS CLI is configured with proper credentials in Jenkins
                sh 'aws s3 cp my_flask_app.zip s3://$S3_BUCKET/'
            }
        }

        stage('Deploy with CodeDeploy') {
            steps {
                script {
                    sh """
                    aws deploy create-deployment \
                        --application-name $APPLICATION_NAME \
                        --deployment-group-name $DEPLOYMENT_GROUP \
                        --s3-location bucket=$S3_BUCKET,key=my_web_app.zip,bundleType=zip \
                        --region $AWS_REGION
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}





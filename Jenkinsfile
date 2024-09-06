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
        S3_BUCKET = 'jenkins-server '
        S3_FILE = 'my_flask_app.zip'
        AWS_REGION = 'ap-south-1'
        APPLICATION_NAME = 'jenkin-CICD'
        DEPLOYMENT_GROUP = 'jenkins-dg'
        DEPLOYMENT_CONFIG = 'CodeDeployDefault.OneAtATime'
    }

    stages {
        stage('Package Application') {
            steps {
                script {
                    // Package the application files into a zip file
                    sh 'zip -r my_flask_app.zip app.py requirements.txt appspec.yml scripts/'
                }
            }
        }
    stage('Install AWS CLI') {
        steps {
            script {
                sh '''
                    if ! command -v aws &> /dev/null; then
                        echo "AWS CLI not found, installing..."
                        sudo apt-get update
                        sudo apt-get install -y awscli
                    else
                        echo "AWS CLI already installed."
                    fi
                '''
            }
        }
    }

        stage('Upload to S3') {
            steps {
                script {
                    // Upload the package to S3
                    sh "aws s3 cp my_flask_app.zip s3://$S3_BUCKET/$S3_FILE"
                }
            }
        }

        stage('Deploy to AWS CodeDeploy') {
            steps {
                script {
                    // Trigger a deployment in AWS CodeDeploy
                    awsCodeDeploy(
                        applicationName: "${APPLICATION_NAME}",
                        deploymentGroupName: "${DEPLOYMENT_GROUP}",
                        deploymentConfigName: "${DEPLOYMENT_CONFIG}",
                        deploymentRevisionLocation: [
                            s3Location: [
                                bucket: "${S3_BUCKET}",
                                key: "${S3_FILE}",
                                bundleType: 'zip'
                            ],
                            revisionType: 'S3'
                        ],
                        region: "${AWS_REGION}"
                    )
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Cleanup steps can go here if necessary
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}


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
        S3_BUCKET_NAME = 'jenkins-server '  // Replace with your actual S3 bucket name
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code...'
                // Checkout the code from GitHub
                git branch: 'master', url: 'https://github.com/Sona-Yadav/simplehelloworld.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                // Add your build commands here if needed, e.g., for Python: sh 'pip install -r requirements.txt'
            }
        }

        stage('Package') {
            steps {
                echo 'Packaging the application...'
                // Create a zip file containing the necessary deployment files
                sh 'zip -r app.zip app.py appspec.yml requirements.txt scripts/'
            }
        }

        stage('Upload to S3') {
            steps {
                echo 'Uploading to S3...'
                
                // Upload the zip file to the S3 bucket
                withAWS(region: "${AWS_REGION}") {
                    s3Upload(bucket: "${S3_BUCKET_NAME}", file: 'app.zip', path: 'app.zip')
                }
            }
        }

        stage('Deploy to AWS CodeDeploy') {
            steps {
                echo 'Deploying to AWS CodeDeploy...'
                
                // Trigger AWS CodeDeploy using the AWS CodeDeploy plugin
                step([
                    $class: 'AWSCodeDeployPublisher',
                    applicationName: "${APPLICATION_NAME}",
                    deploymentGroupName: "${DEPLOYMENT_GROUP_NAME}",
                    deploymentRevisionLocation: [
                        revisionType: 'S3',  // Use S3 as the source of your code
                        s3Location: [
                            bucket: "${S3_BUCKET_NAME}",
                            key: 'app.zip',  // The path in the S3 bucket to your zip file
                            bundleType: 'zip'  // Specify the type of file (e.g., zip, tar, etc.)
                        ]
                    ]
                ])
            }
        }
    }
}


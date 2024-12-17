pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('975050173141') // Replace with Jenkins credential ID for AWS
        AWS_SECRET_ACCESS_KEY = credentials('AKIA6GBME5LKXSVMO2MX') // Replace with Jenkins credential ID for AWS
    }
    stages {
        stage('Terraform Init') {
            steps {
                sh '''
                terraform init
                '''
            }
        }
        stage('Terraform Destroy') {
            steps {
                sh '''
                terraform destroy -auto-approve
                '''
            }
        }
    }
    post {
        always {
            echo 'Pipeline completed.'
        }
        success {
            echo 'Resources destroyed successfully!'
        }
        failure {
            echo 'Failed to destroy resources.'
        }
    }
}






pipeline {
    agent any  // Use any available agent

    environment {
        // Define AWS credentials and destroy flag
        AWS_CREDENTIALS_ID = '975050173141'
        
        // Set this to 'false' to avoid destroying resources
        DESTROY_RESOURCES = 'true'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                // Checkout code from the repository
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize Terraform
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-east-1')]) {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Generate Terraform plan
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-east-1')]) {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { env.DESTROY_RESOURCES == 'true' }  // Only apply if not destroying resources
            }
            steps {
                script {
                    // Apply the Terraform plan with auto-approval
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-east-1')]) {
                        sh 'terraform apply --auto-approve tfplan'
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { env.DESTROY_RESOURCES == 'false' }  // Destroy resources if the flag is set to true
            }
            steps {
                script {
                    echo "Destroying all resources..."
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-east-1')]) {
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                // Cleanup workspace or other post-build actions
                echo 'Cleaning up workspace...'
                cleanWs()
            }
        }

        success {
            echo 'Pipeline succeeded!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }








/*

pipeline {
    agent any  // Use any available agent

    environment {
        // Define any environment variables here, if needed
        // Example: AWS credentials ID for use with Terraform
        AWS_CREDENTIALS_ID = '975050173141'
        
        // Set this to 'true' or 'false' depending on whether you want to allow destruction
        DESTROY_RESOURCES = 'false'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                // Checkout code from the repository
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize Terraform
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-east-1')]) {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Generate Terraform plan
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-east-1')]) {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply the Terraform plan with auto-approval
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-east-1')]) {
                        sh 'terraform apply --auto-approve tfplan'
                    }
                }
            }
        }
          stage('Terraform Destroy') {
    steps {
        script {
            if (env.DESTROY_RESOURCES == 'true') {
                echo "Destroying resources as DESTROY_RESOURCES is set to true."
                withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-east-1')]) {
                    sh 'terraform destroy --auto-approve'
                }
            } else {
                echo "Skipping Terraform destroy as DESTROY_RESOURCES is not set to true."
            }
        }
    }
}  
       /* stage('Terraform Destroy') {
            steps {
                script {
                    if (env.DESTROY_RESOURCES == 'true') {
                        withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-east-1')]) {
                            sh 'terraform destroy --auto-approve'
                        }
                    } else {
                          echo "destroy as DESTROY_RESOURCES is set to true."      
                        //echo "Skipping Terraform destroy as DESTROY_RESOURCES is set to true."
                    }
                }
            } 
        }
    }

    post {
        always {
            script {
                // Cleanup workspace or other post-build actions
                echo 'Cleaning up...'
                cleanWs()
            }
        }

        success {
            echo 'Pipeline succeeded!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }
}

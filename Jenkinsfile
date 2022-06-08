pipeline {
    agent anydfgdfdf

    parameters {
        string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
        // string(name: 'version', defaultValue: '', description: 'Version variable to pass to Terraform')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }
    
    environment {
        TF_IN_AUTOMATION      = '1'
    }

    stages {
        stage('Plan') {
            steps {
                script {
                    currentBuild.displayName = params.version
                    withAWS(credentials: 'aws-fabioacc') {
                    sh 'terraform --version'
                    sh 'terraform init'
                    sh 'terraform workspace select ${environment}'
                    sh "terraform plan -out tfplan"
                    sh 'terraform show -no-color tfplan > tfplan.txt'
                }   
            }
                
        }
        }

        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }

            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            steps {
                script {
                    withAWS(credentials: 'aws-fabioacc') {
                    sh "terraform apply tfplan"
                    }   
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'tfplan.txt'
        }
    }
}

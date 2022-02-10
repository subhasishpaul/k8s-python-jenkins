pipeline {
    environment {
        imagename = "subhasishpaul/python"
        registryCredential = 'docker-hub-credentials'
        dockerImage = ''
    }
    
    agent any

    stages {
        stage('Git clone') {
            steps {
                echo 'Git Cloning Started ...'
                git credentialsId: 'GIT_CRED', url: 'https://github.com/subhasishpaul/k8s-python-jenkins.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                docker.build("subhasishpaul/python:${env.BUILD_ID}")
            }
        }
        
        stage('Push Docker Image ') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push("$BUILD_NUMBER")
                        dockerImage.push('latest')
                    }
                }
            }
        }
        
        stage('Remove Unused docker image') {
            steps{
                bat "docker rmi $imagename:$BUILD_NUMBER"
                bat "docker rmi $imagename:latest"
            }
        }
        
        stage('Deploy To Kuberates Cluster ') {
            steps {
                kubernetesDeploy(
                   configs: 'kubernetes/deployments/deployment.yaml', 
                   kubeconfigId: 'K8S_CLUSTER_CONFIG',
                   enableConfigSubstitution: true
        )

            }
        }
        
        stage('Sending Email') {
            steps {
                emailext attachLog: true, body: '''$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:
                Check console output at $BUILD_URL to view the results.''', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'subhasish2077@gmail.com'}
        }
        
    }
}

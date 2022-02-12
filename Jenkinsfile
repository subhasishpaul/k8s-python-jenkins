pipeline {
    environment { 
       repo = "subhasishpaul/python"
       ver = "${env.BUILD_ID}"
       image = "${NAME}:${VERSION}"
    }

    agent any

    stages {
        stage('Git clone') {
            steps {
                echo 'Git Cloning Started ...'
                echo "Running ${env.BUILD_NUMBER} on ${env.JENKINS_URL} - ${repo}"
                git credentialsId: 'GIT_CRED', url: 'https://github.com/subhasishpaul/k8s-python-jenkins.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t ${repo} .'
            }
        }
        
        stage('Push Docker Image ') {
            steps {
                bat 'docker login -u subhasishpaul -p Anushka@1977'
                /** withCredentials([string(credentialsId: 'DOCKER_HUB_PASSWORD', variable: 'DOCKER_HUB_PASSWORD')]) {
                bat 'docker login -u subhasishpaul -p ${DOCKER_HUB_PASSWORD}'
                } **/
                bat 'docker push subhasishpaul/python:${env.BUILD_ID}'
            }
        }
        
        stage('Deploy To Kuberates Cluster ') {
            steps {
                kubernetesDeploy(
                   configs: 'kubernetes/deployments/deployment.yaml', 
                   kubeconfigId: 'K8S_CLUSTER_CONFIG',
                   enableConfigSubstitution: true
                )
                bat 'kubectl set image kubernetes/deployments/deployment/example-deploy example-app=subhasishpaul/python:${env.BUILD_ID}'

            }
        }
        
        stage('Sending Email') {
            steps {
                emailext attachLog: true, body: '''$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:
                Check console output at $BUILD_URL to view the results.''', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'subhasish2077@gmail.com'}
        }
        
    }
}


pipeline {
    agent any

    stages {
        stage('Git clone') {
            steps {
                echo 'Git Cloning started'
                git credentialsId: 'GIT_CRED', url: 'https://github.com/subhasishpaul/k8s-python-jenkins.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t subhasishpaul/python .'
            }
        }
        stage('Deploy....') {
            steps {
                echo 'Deploying application'
            }
        }
        stage('Sending Email') {
            steps {
                emailext attachLog: true, body: '''$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:
                Check console output at $BUILD_URL to view the results.''', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'subhasish2077@gmail.com'}
        }
        
    }
}

pipeline {

  environment {
    APP_NAME = "${JOB_NAME}"
    GIT_REPO = "https://github.com/Arboulahdour/pyflask.git"
    DOCKER_IMAGE = "arboulahdour/pyflask"
    REGISTRY_CRED = "docker-hub-creds"
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git([url: "$GIT_REPO", 
             branch: 'master', 
             credentialsId: 'github-user-token'
          ]
        )
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build DOCKER_IMAGE + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( '', REGISTRY_CRED ) {
            dockerImage.push("$BUILD_NUMBER")
          }
        }
      }
    }

    stage('Deploy Application') {
      steps{
        sh "docker run -d --name $APP_NAME -p 5000:5000 $DOCKER_IMAGE:$BUILD_NUMBER"
      }
    }
  }
}
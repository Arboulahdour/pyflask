pipeline {

  environment {
    JOB_NAME = "${JOB_NAME}"
    GIT_REPO = "https://github.com/Arboulahdour/sample.git"
    DOCKER_IMAGE = "arboulahdour/sample"
    REGISTRY_CRED = "docker-hub-creds"
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git([url: "$GIT_REPO", branch: 'master', credentialsId: 'github-user-token'])
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
             dockerImage.push('latest')
          }
        }
      }
    }

    // stage('Deploy App') {
    //   steps {
    //     script {
    //       kubernetesDeploy(configs: "myweb.yaml", kubeconfigId: "mykubeconfig")
    //     }
    //   }
    // }

  }

}
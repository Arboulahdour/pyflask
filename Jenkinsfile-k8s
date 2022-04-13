pipeline {
    
  environment {
        JOB_NAME = "${JOB_NAME}"
        REGISTRY = "my-docker-registry"
    }

  agent any

  stages {

    stage('Clone the repo') {
      steps {
        git url:'https://github.com/Arboulahdour/sample.git', branch:'master'
      }
    }
    
    stage('Deploy the application') {
      steps {
        script {
          kubernetesDeploy(
                kubeconfigId: 'cluster-config-file',
                configs: 'deployment.yml',
                enableConfigSubstitution: true
            )
        }
        script {
          kubernetesDeploy(
                kubeconfigId: 'cluster-config-file',
                configs: 'service.yml',
                enableConfigSubstitution: true
            )
        }
      }
    }
  }
}

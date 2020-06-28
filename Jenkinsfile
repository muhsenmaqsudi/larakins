pipeline {
  agent any
  stages {
    stage('build') {
      agent {
        dockerfile {
          filename 'Dockerfile'
        }

      }
      steps {
        echo 'Started building'
        sh 'docker build -t muhsenmaqsudi/larakins .'
      }
    }

  }
}
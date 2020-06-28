pipeline {
  agent any
  triggers {
    pollSCM('H */4 * * 1-5')
  }
  stages {
    stage('build') {
      agent {
        dockerfile {
          filename 'Dockerfile'
        }
      }
      steps {
        echo 'Started building'
//         sh 'docker build -t muhsenmaqsudi/larakins .'
        sh 'ssh maqsudi@hsproject.ir'
      }
    }
  }
}

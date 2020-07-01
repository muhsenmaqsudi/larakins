pipeline {
  agent none
  stages {
    stage('BuildAndTest') {
      matrix {
        agent any
        axes {
          axis {
            name 'PLATFORM'
            values 'linux', 'windows', 'mac'
          }
        }
        stages {
          stage('Build') {
            steps {
              echo "Do Build for ${PLATFORM}"
            }
          }
          stage('Test') {
            steps {
              echo "Do Test for ${PLATFORM}"
            }
          }
        }
      }
    }
  }
  post {
    always {
      sh 'php -v'
      sh 'pwd'
      sh 'ls'
      echo 'I will always say Hello again!'
    }
    success {
      echo 'success'
      sh 'ssh maqsudi@hsproject.ir'
    }
    failure {
      echo 'failed'
    }
  }
}

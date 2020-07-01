pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'composer install'        
      }
    }
    stage('Test') {
      steps {
          echo 'Testing..'
      }
    }
    stage('Deploy') {
      steps {
          echo 'Deploying....'
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

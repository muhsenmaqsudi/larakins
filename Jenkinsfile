pipeline {
  agent any
  stages {
    stage('BuildAndTest') {
      matrix {
        agent any
        axes {
          axis {
            name 'PLATFORM'
            values 'linux', 'windows'
          }
        }
        stages {
          stage('Build') {
            steps {
              slackSend color: '#BADA55', message: 'Build Started', channel: 'jenkins'
              echo "Do Build for ${PLATFORM}"
              sh 'composer install'
              sh 'cp .env.example .env'
              sh 'php artisan key:generate'
            }
          }
          stage('Test') {
            steps {
              echo "Do Test for ${PLATFORM}"
              sh 'php artisan test'
            }
          }
        }
      }
    }
    stage('Deploy') {
      steps([$class: 'BapSshPromotionPublisherPlugin']) {
        sshPublisher(
          continueOnError: false, failOnError: true,
          publishers: [
              sshPublisherDesc(
                  configName: 'barakat_test_server',
                  verbose: true,
                  transfers: [
                      sshTransfer(sourceFiles: '**'),
                      // sshTransfer(remoteDirectory: '/home/maqsudi/workspace/testing_jenkins'),
                      // sshTransfer(execCommand: '/home/maqsudi/workspace/testing_jenkins php artisan route:list')
                  ]
              )
          ]
      )
      }
    }
  }
  post {
    always {
      echo 'I will always say Hello again!'
    }
    success {
      slackSend color: '#BADA55', message: 'Successful Build', channel: 'jenkins'
      sh 'php -v'
      sh 'pwd'
      sh 'ls'
      sh 'ssh maqsudi@hsproject.ir'
    }
    failure {
      echo 'failed'
    }
  }
}

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
          stage('SSH transfer') {
            steps([$class: 'BapSshPromotionPublisherPlugin']) {
              sshPublisher(
                continueOnError: false, failOnError: true,
                publishers: [
                    sshPublisherDesc(
                        configName: 'barakat_test_server',
                        verbose: true,
                        transfers: [
                            sshTransfer(sourceFiles: './larakins_master')
                            sshTransfer(remoteDirectory: '/home/maqsudi/workspace/testing_jenkins')
                            sshTransfer(execCommand: 'php artisan route:list'),
                        ]
                    )
                ]
            )
            }
          }
        }
      }
    }
  }
  post {
    always {
      echo 'I will always say Hello again!'
    }
    success {
      echo 'success'
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

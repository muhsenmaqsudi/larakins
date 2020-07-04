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
              slackSend color: '#2962ff', message: "started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>) CI/CD Build Stage for ${PLATFORM}", channel: '#jenkins'
              sh 'composer install'
              sh 'cp .env.example .env'
              sh 'php artisan key:generate'
            }
          }
          stage('Test') {
            steps {
              slackSend color: '#ffff00', message: "started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>) CI/CD Test Stage for ${PLATFORM}", channel: '#jenkins'
              sh 'php artisan test'
            }
          }
        }
      }
    }
    stage('Deploy') {
//       steps([$class: 'BapSshPromotionPublisherPlugin']) {
    steps {
           sshPublisher(
             continueOnError: false, failOnError: true,
             publishers: [
              sshPublisherDesc(
              configName: "barakat_test_server",
    //            configName: "${env.SSH_CONFIG_NAME}",
               verbose: true,
               transfers: [
                sshTransfer(
                 sourceFiles: "**",
    //              removePrefix: "${path_to_file}",
    //              remoteDirectory: "${remote_dir_path}",
                 execCommand: "ls"
                )
               ])
             ])
    }

//         sshPublisher(
//           continueOnError: false, failOnError: true,
//           publishers: [
//               sshPublisherDesc(
//                   configName: 'barakat_test_server',
//                   verbose: true,
//                   transfers: [
//                       sshTransfer(sourceFiles: '**'),
//                       // sshTransfer(remoteDirectory: '/home/maqsudi/workspace/testing_jenkins'),
//                       // sshTransfer(execCommand: '/home/maqsudi/workspace/testing_jenkins php artisan route:list')
//                   ]
//               )
//           ]
//       ),
//       }
    }
  }
  post {
    always {
      echo 'I will always say Hello again!'
    }
    success {
      slackSend color: '#76ff03', message: 'Larakins Successfully Deployed', channel: '#jenkins'
      sh 'php -v'
      sh 'pwd'
      sh 'ls'
    }
    failure {
      slackSend color: '#ff1744', message: 'Larakins Deployment Failed', channel: '#jenkins'
    }
  }
}

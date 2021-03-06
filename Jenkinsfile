pipeline {
  agent any
  environment {
    REMOTE_DIR = "/home/maqsudi/workspace/larakins"
  }
  stages {
    stage("BuildAndTest") {
      matrix {
        agent any
        axes {
          axis {
            name "PLATFORM"
            values "linux", "windows"
          }
        }
        stages {
          stage("Build") {
            steps {
              slackSend color: "#2962ff", message: "started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>) CI/CD Build Stage for ${PLATFORM}", channel: "#jenkins"
              sh "composer install"
              sh "cp .env.example .env"
              sh "php artisan key:generate"
            }
          }
          stage("Test") {
            steps {
              slackSend color: "#ffff00", message: "started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>) CI/CD Test Stage for ${PLATFORM}", channel: "#jenkins"
              sh "php artisan test"
            }
          }
        }
      }
    }
    stage("Deploy") {
      steps {
        sshPublisher(
          continueOnError: false, failOnError: true, alwaysPublishFromMaster: true,
          publishers: [
          sshPublisherDesc(
            configName: "barakat_test_server",
            verbose: true,
            useWorkspaceInPromotion: true,
            transfers: [
              sshTransfer(sourceFiles: "**", makeEmptyDirs: true),
              sshTransfer(execCommand: "cd ${REMOTE_DIR};sh deploy.sh")
            ])
          ])
      }
    }
  }
  post {
    success {
      slackSend color: "#76ff03", message: "Larakins Successfully Deployed", channel: "#jenkins"
    }
    failure {
      slackSend color: "#ff1744", message: "Larakins Deployment Failed", channel: "#jenkins"
    }
  }
}

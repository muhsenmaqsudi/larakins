pipeline {
  agent any
  triggers {
    pollSCM('H */4 * * 1-5')
  }
    def remote = [:]
    remote.name = 'hsproject'
    remote.host = 'hsrpoject.ir'
    remote.user = 'maqsudi'
    remote.password = 'mqf121810'
    remote.allowAnyHosts = true
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
      stage('Remote SSH') {
        sshCommand remote: remote, command: "ls -lrt"
        sshCommand remote: remote, command: "for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done"
      }

  }
}

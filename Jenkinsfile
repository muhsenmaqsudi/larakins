// node('master') {
//     try {
//         stage('build') {
//             // Checkout the app at the given commit sha from the webhook
//             checkout scm

//             // Install dependencies, create a new .env file and generate a new key, just for testing
//             sh 'docker run --rm --volume $(pwd):/app composer install --no-ansi'
//             sh 'cp .env.example .env'
//             sh 'docker run --rm --name key-generate-container -v $(pwd):/usr/src/app -w /usr/src/app php:7.2-cli php artisan key:generate'            

//             // Run any static asset building, if needed
//             // sh "npm install && gulp --production"
//         }

//         stage('test') {
//             // Run any testing suites
//             sh 'docker run --rm --name phpunit-container -v $(pwd):/usr/src/app -w /usr/src/app php:7.2-cli php ./vendor/bin/phpunit'
//         }

//         stage('deploy') {
//             // If we had ansible installed on the server, setup to run an ansible playbook
//             // sh 'ansible-playbook -i ./ansible/hosts ./ansible/deploy.yml'
//             // sh "echo 'WE ARE DEPLOYING'"
//         }
//     } catch(error) {
//         throw error
//     } finally {
//         // Any cleanup operations needed, whether we hit an error or not
//     }

// }


// pipeline {
//   agent any
//   triggers {
//     pollSCM('H */4 * * 1-5')
//   }
//   stages {
//     stage('build') {
//       agent {
//         dockerfile {
//           filename 'Dockerfile'
//         }
//       }
//       steps {
//         echo 'Started building'
//       }
//     }
//   }
//   post {
//     always {
//       echo 'I will always say Hello again!'
//     }
//     success {
      
//     }
//   }
// }



node('master') {
    stage('install') {
        sh 'composer install'
    }
    stage('init') {
    	sh 'cp .env.example .env'
    	sh 'php artisan key:generate'
    	sh "sed -i -e 's/DB_DATABASE=homestead/DB_DATABASE=staging/g' .env"
    	sh "sed -i -e 's/DB_USERNAME=homestead/DB_USERNAME=yourusername/g' .env"
    	sh "sed -i -e 's/DB_PASSWORD=secret/DB_PASSWORD=yourpassword/g' .env"
    }
    stage('integration_testing') {
    	sh 'vendor/bin/phpunit tests/Feature'
    }
    stage('acceptance_testing') {
    	// Because we'll use database as session driver during testing, we have to explictly migrate sessions table.
        sh 'php artisan migrate'
    	sh 'cp .env .env.dusk.local'
    	sh "sed -i -e 's;APP_URL=http://localhost;APP_URL=your.domain.com;g' .env.dusk.local"
    	// Use database as session driver instead of file so that every single test will not share the same session context.
    	sh "sed -i -e 's/SESSION_DRIVER=file/SESSION_DRIVER=database/g' .env.dusk.local"
    	// Allow web server to access storage directory.
    	sh 'sudo chmod -R 775 storage/'
    	sh 'sudo chown -R :www-data storage/'
    	sh 'php artisan dusk'
    }
}
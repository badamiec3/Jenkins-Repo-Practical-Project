pipeline {
  agent any
  environment{
      DOCKER_USER=credentials('DOCKER_USER')
      DOCKER_PASSWORD=credentials('DOCKER_PASSWORD')
      SECRET_KEY=credentials('SECRET_KEY')
      DATABASE_URI=credentials('DATABASE_URI')
      TEST_DATABASE_URI=credentials('TEST_DATABASE_URI')
      AWS_ACCESS_KEY=credentials('AWS_ACCESS_KEY')
      AWS_SECRET_KEY=credentials('AWS_SECRET_KEY')
      
  }
  stages {
      stage('get repo') {
        steps {
            sh 'chmod a+x ./scripts/get-repo.sh'
            sh './scripts/get-repo.sh'
        }
      }
    stage('docker login') {
        steps {
          sh 'sudo docker login --username=${DOCKER_USER} --password=${DOCKER_PASSWORD}'
        }
      }
    stage('run frontend tests') {
        steps {
            sh 'chmod a+x ./scripts/ftests.sh'
            sh './scripts/ftests.sh'
        }
      }
    stage('run backend tests') {
        steps {
            sh 'chmod a+x ./scripts/btests.sh'
            sh './scripts/btests.sh'
        }
      }
    stage('docker build and push frontend') {
        steps {
          sh 'chmod a+x ./scripts/docker-push-frontend.sh'
          sh './scripts/docker-push-frontend.sh'
        }
      }
     stage('docker build and push backend') {
        steps {
          sh 'chmod a+x ./scripts/docker-push-backend.sh'
          sh './scripts/docker-push-backend.sh'
        }
      }
     stage('kubectl apply') {
         steps {
           sh 'chmod a+x ./scripts/kubectl-su.sh'
           sh './scripts/kubectl-su.sh'
         }
       }
    
     stage('kubectl') {
        steps {
          sh 'chmod a+x ./scripts/kubectl.sh'
          sh './scripts/kubectl.sh'
        }
      }
   }
}
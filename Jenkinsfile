pipeline {
  environment {
    registry = "houseofcards11/helloworld"
    registryCredential = 'docker-hub'
	dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/sansgit1/devopsjenkins.git', branch: 'master'])
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
             dockerImage.push('latest')

          }
        }
      }
    }
    stage('Deploy image and Remove Unused  image') {
      steps{
        sh "docker stop devops"
        sh "docker rm devops"
        sh "docker container run -d -p 8000:80 --name devops houseofcards11/helloworld:$BUILD_NUMBER"
        echo 'Cleaning up'
       
      }
    }
  }
}

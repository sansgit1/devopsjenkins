﻿pipeline {
  environment {
    imagename = "houseofcards11/helloworld"
    registryCredential = 'docker-hub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git([url: 'git@github.com:sansgit1/devopsjenkins.git', branch: 'master', credentialsId: 'github-ssh-key'])

      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build imagename
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
        sh "docker run -d -p 80:80 --name devops $imagename:$BUILD_NUMBER"
        sh "docker rmi $imagename:$BUILD_NUMBER"

      }
    }
  }
}

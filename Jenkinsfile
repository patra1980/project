pipeline {
    agent any
 
    stages {
        stage('Validate') {
            steps {
                echo 'Validating..'
                sh 'pwd'
                sh 'mvn package'
            }
        }
        stage ('Build Docker image') {
            steps {
                echo 'Testing..'
                echo 'docker build -t myproject1 . 
            }
             
        }
        }      

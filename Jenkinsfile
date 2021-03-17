pipeline {
    agent any

    stages {
        stage('SCM') {
            steps {
                git 'https://github.com/Preetam11/project.git'
                sh 'mvn test'
            }
        }
        stage('SonarQube analysis') {
           steps{
           withSonarQubeEnv('sonarserver') {
                         sh 'mvn clean package sonar:sonar'
                        }// submitted SonarQube taskId is automatically attached to the pipeline context
           }        
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker image'){
            steps{
                sh 'docker build -t princebitla/repo:Endgame .'
            }
        }
        stage('Docker push'){
            steps{
                withCredentials([string(credentialsId: 'repos', variable: 'repo')]) {
                // some block
                sh 'docker login -u princebitla -p "${repo}"'
                sh 'docker push princebitla/repo:Endgame'
                   }
                }
        }
        stage('Ansible playbook'){
            steps{
                ansiblePlaybook become: true, installation: 'Ansible', inventory: 'hosts', playbook: 'ansible.yaml'
                }
        }
    }
}    

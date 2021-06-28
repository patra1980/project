pipeline {
    environment {
           registry = "patrautpal80/myproject"
           registryCredential = 'docker-hub'
           dockerImage = ''
          }
    agent any
    stages{


         stage("Ansible"){
            steps{
                node('ansible-label')
                 {
                    git 'https://github.com/patra1980/project.git'
                    ansiblePlaybook credentialsId: 'private-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'ansible.ini', playbook: 'ansible.yml'
                 }
                }
              }

 
         stage("SCM"){
            steps{
                   node('scm-node-label') 
                   {
                    git 'https://github.com/patra1980/project.git'
                    sh 'mvn clean'
                    sh 'mvn package'
                    sh 'mvn deploy'
                   }
                 }
               }
            
         stage("SonarQube")
         {
            steps{
                node('sonarserver')
                  {
                    git 'https://github.com/patra1980/project.git'
                    script{  
                     def scannerHome = tool 'SonarQube Scanner';
                   withSonarQubeEnv('sonarqube') { 
                       sh "${scannerHome}/bin/sonar-scanner \
                       -D sonar.login=admin \
                       -D sonar.password=admin \
                       -D sonar.projectKey=sonartest \
                       -D sonar.sources=./ \
                       -D sonar.exclusions=vendor/**,resource/**,**/*.java \
                       -D sonar.host.url=http://172.31.78.187:9000/" }
                   }
                   }
                 }
          }
         
         stage("Docker")
         {
             steps{
                 node('dockerserver')   
                    {
                   git 'https://github.com/patra1980/project.git'
                   sh 'mvn clean'
                   sh 'mvn package' 
                   script{
                       dockerImage = docker.build registry + ":$BUILD_NUMBER"  
                       docker.withRegistry( '', registryCredential ) {   
                           dockerImage.push("$BUILD_NUMBER")
                           dockerImage.push('latest') }
                           sh "docker rmi $registry:$BUILD_NUMBER"
                           sh "docker rmi $registry:latest"
                           }	
                         }
                      }
                    }
         
        
          stage("NEXUS"){
            steps{
                   node('nexus-node-label') 
                   {
                    git 'https://github.com/patra1980/project.git'
           
                   }
                 }
               }      
}

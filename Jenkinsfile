pipeline {
    environment {
           DOCKERHUB_CREDENTIALS = credentials('patra1980-dockerhub')
    }
    agent any
    stages{
 
         stage("SCM"){
            steps{
                node('scm-node-label') 
                 {
                    git 'https://github.com/patra1980/project.git'
                 }
                }
              }
            
         stage("SonarQube")
         {
            steps{
                node('sonarserver')
                  {
                    script{  
                     def scannerHome = tool 'SonarQube Scanner';
                   withSonarQubeEnv('sonarqube') { 
                       sh "${scannerHome}/bin/sonar-scanner \
                       -D sonar.login=admin \
                       -D sonar.password=admin \
                       -D sonar.projectKey=sonarqubetest \
                       -D sonar.sources=. \
                       -D sonar.exclusions=vendor/**,resource/**,**/*.java \
                       -D sonar.host.url=http://172.31.78.187:9000/" }
                   }
                   }
                 }
        }
         
         stage("docker")
         {
             steps{
                 node('dockerserver')
                 {
                   sh 'docker image rm -f patrautpal80/myproject'
                   sh 'sudo docker build -t patrautpal80/myproject .'
  	           sh 'docker login -u patrautpal80 -p patra_utpal@1980'
		   sh 'docker push patrautpal80/myproject' 		
                 }
             }
         }
    }
}

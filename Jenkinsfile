pipeline {
    agent any
    stages{
        stage("build"){
            steps{
                node('build-node-label') 
                 {
                    git 'https://github.com/patra1980/project.git'
                    sh 'mvn clean'
                    sh 'mvn package'
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
                       -D sonar.host.url=http://3.237.22.128:8080/" }
                   }
                   }
                 }
        }
         
         stage("docker")
         {
             steps{
                 node('dockerserver')
                 {
                   sh 'sudo docker build -t myproject .'
                 }
             }
         }
    }
}

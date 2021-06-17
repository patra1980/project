FROM tomcat:7
COPY target/*.war /usr/local/tomcat/webapps.dist/
RUN mv webapps.dist/* webapps
RUN usermod -a -G docker jenkins
EXPOSE 8080

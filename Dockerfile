FROM tomcat
ADD target/*.war /usr/local/tomcat/webapps.dist/
EXPOSE 8080
ENTRYPOINT ["sh", "/usr/local/tomcat/bin/catalina.sh", "run"]

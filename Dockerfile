FROM tomcat
ADD target/*.war /usr/local/tomcat/webapps.dist/
RUN rmdir webapps
RUN mv webapps.dist webapps
EXPOSE 8080
ENTRYPOINT ["sh", "/usr/local/tomcat/bin/catalina.sh", "run"]


FROM tomcat 
WORKDIR webapps 
COPY target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
ENTRYPOINT ["sh", "/usr/local/tomcat/bin/startup.sh"]

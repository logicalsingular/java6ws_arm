# FROM arm64v8/debian:stable
FROM amd64/debian:stretch
ENV DEBIAN_FRONTEND=noninteractive
COPY sources.list /etc/apt/
RUN apt update -y  
RUN apt install java-package bash libxt6 java-common -y
RUN groupadd -r java6 && useradd java6 -s /bin/bash -m -d /home/java6 -r -g java6
COPY ./java6utils/* /home/java6
RUN chown -R java6:java6 /home/java6
USER java6 
WORKDIR /home/java6
RUN chmod +x build.sh
RUN ./build.sh
USER root
RUN ls -la 
RUN chmod +x install.sh
RUN ./install.sh
RUN export PATH="/usr/lib/jvm/oracle-java6-jdk-amd64/bin/:$PATH"
RUN java -version
RUN javac -version

# RUN apt install oracle-java6-jdk_6u45_amd64.deb -y

#CMD [ "javaws srv248.swdc.ams1.nl.jnlp" ]
# /usr/lib/jvm/oracle-java6-jdk-amd64/bin/javac -version
# /usr/lib/jvm/oracle-java6-jdk-amd64/bin/java -version
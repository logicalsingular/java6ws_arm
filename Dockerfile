
FROM amd64/debian:buster
# FROM ubuntu
# ENV DEBIAN_FRONTEND=noninteractive
COPY sources.list /etc/apt/
RUN apt update -y  
RUN apt install java-package bash libxt6 java-common -y
RUN groupadd -r java6ws && useradd java6ws -s /bin/bash -m -d /home/java6ws -r -g java6ws
COPY ./java6utils/* /home/java6ws
RUN chown -R java6ws:java6ws /home/java6ws
USER java6ws
WORKDIR /home/java6ws
RUN chmod +x build.sh
RUN ./build.sh
USER root
RUN ls -la 
RUN chmod +x install.sh
RUN ./install.sh
RUN export PATH="/usr/lib/jvm/oracle-java6-jdk-amd64/bin/:$PATH"
RUN java -version
RUN javac -version
RUN chmod +x run.sh

COPY deb/* /tmp/
RUN uname -a
RUN apt-get -qy install libffi6
RUN apt-get -qy install /tmp/*.deb

ENTRYPOINT ["/usr/bin/firefox-esr"]

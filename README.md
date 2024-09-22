Install X11 Quartz Winwows Manager:
https://www.xquartz.org

Open xQuartz and run command:
xhost + 
Output after this command should be like this:
"access control disabled, clients can connect from any host"
Open xQuartz Settings:
Tab Security -> set checkbox to Allow connection from network clients 

BUILD Container:
docker build -t java6ws:0.0.1 .

RUN container:
docker run -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=host.docker.internal:0 --platform linux/amd64 --name java6ws -d java6ws:0.0.1



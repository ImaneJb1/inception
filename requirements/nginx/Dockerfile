FROM debian:latest

RUN apt update && apt install -y sudo
RUN sudo apt update && sudo apt upgrade && apt install -y nginx

CMD ["nginx", "g", "daemon off;"]
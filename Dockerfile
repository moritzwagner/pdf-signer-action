FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y python3-pip

RUN pip3 install pyhanko

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y texlive-full python3-pip jq

RUN pip3 install pyhanko

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

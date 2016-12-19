FROM debian:jessie-backports
#Changed to the backports version so that I could install letsencrypt with the package manager
#I was getting stuck on the python setup of "cryptography" like several others

RUN apt-get update \
  && apt-get install -y letsencrypt -t jessie-backports \
  && apt-get install -y curl -t jessie-backports \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

WORKDIR /certbot
COPY run.sh /certbot/run.sh
COPY post_cert.py /certbot/post_cert.py

#I added this line because my docker containers seemed to be not getting my updates
RUN sh -c 'touch /certbot/run.sh' && sh -c 'touch /certbot/post_cert.py'

ENTRYPOINT ["/certbot/run.sh"]
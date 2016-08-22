FROM python:2.7.12-alpine

RUN echo "http://dl-6.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update
#RUN apk add py-pyldap
#RUN apk add --no-cache --virtual .build-deps openldap-dev build-base git
RUN apk add build-base git libldap libsasl libbz2 openssl-dev openldap-dev
#RUN apk add py-pyldap
RUN pip install python-ldap
RUN mkdir /opt && cd /opt && \
    git clone https://github.com/nginxinc/nginx-ldap-auth.git && \
    sed -i 's/localhost/0.0.0.0/g' nginx-ldap-auth/nginx-ldap-auth-daemon.py
#RUN apk del .build-deps

CMD /opt/nginx-ldap-auth/nginx-ldap-auth-daemon.py

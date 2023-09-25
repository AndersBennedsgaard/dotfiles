FROM ubuntu:20.04

RUN apt update && \
    apt install openssh-server -y && \
    apt clean all

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    mkdir /root/.ssh && \
    mkdir /var/run/sshd

COPY ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN chmod 400 /root/.ssh/authorized_keys

EXPOSE 22

CMD [ "/usr/sbin/sshd", "-D" ]

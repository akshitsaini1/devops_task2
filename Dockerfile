FROM centos
COPY ./entry-point /usr/local/bin/
RUN dnf install wget openssh-clients.x86_64 expect.x86_64 java-11-openjdk-demo.x86_64 -y
RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
RUN dnf install jenkins -y
RUN dnf install sudo -y
RUN echo -e "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN dnf install git -y
COPY ./jenkins /etc/sysconfig/jenkins
COPY ./keygen /usr/local/bin/
COPY ./copyid /usr/local/bin/
COPY ./scp_demo /usr/local/bin

COPY ./functions /etc/init.d/
COPY ./jen /usr/local/bin/

EXPOSE 8080
CMD entry-point;

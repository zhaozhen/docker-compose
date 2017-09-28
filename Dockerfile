FROM daocloud.io/centos:7

ARG JDK_DOWNLOAD_URL=https://img.maitao.com/zhaozhen/jdk-8u51-linux-x64.rpm
RUN curl -o jdk-8u51-linux-x64.rpm   ${JDK_DOWNLOAD_URL}
RUN rpm -ivh jdk-8u51-linux-x64.rpm
RUN yum -y install git vim unzip


ARG MAVEN_VERSION=3.5.0
ARG USER_HOME_DIR="/opt/maven/"
ARG SHA=beb91419245395bd69a4a6edad5ca3ec1a8b64e41457672dc687c173a495f034
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
ENV JAVA_HOME /usr/java/jdk1.8.0_51

COPY mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY settings-docker.xml /usr/share/maven/ref/
RUN chmod +x  /usr/local/bin/mvn-entrypoint.sh
VOLUME "$USER_HOME_DIR/.m2"

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["bash"]

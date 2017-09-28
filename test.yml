FROM daocloud.io/centos:7

ARG JDK_DOWNLOAD_URL=https://img.maitao.com/zhaozhen/jdk-8u51-linux-x64.rpm
ARG JCE1.8_URL=http://img.maitao.com/jce_policy-8.zip

#install jdk1.8
RUN curl -o jdk-8u51-linux-x64.rpm   ${JDK_DOWNLOAD_URL}
RUN rpm -ivh jdk-8u51-linux-x64.rpm

# install other package
RUN yum -y install git vim unzip

# install jce
RUN curl -o jce_policy-8.zip   ${JCE1.8_URL}

RUN curl -o jce_policy-8.zip   ${JCE1.8_URL}      \
    && unzip  jce_policy-8.zip                 \
    && cp -a /usr/java/jdk1.8.0_51/jre/lib/security  /usr/java/jdk1.8.0_51/jre/lib/security.old \
    && rm -fr /usr/java/jdk1.8.0_51/jre/lib/security/   \
    && mkdir /usr/java/jdk1.8.0_51/jre/lib/security/    \
    && mv UnlimitedJCEPolicyJDK8/*   /usr/java/jdk1.8.0_51/jre/lib/security/   \


ARG MAVEN_VERSION=3.5.0
ARG USER_HOME_DIR="/root"
ARG SHA=beb91419245395bd69a4a6edad5ca3ec1a8b64e41457672dc687c173a495f034
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven  \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn




#删除文件包
RUN rm  -fr jdk-8u51-linux-x64.rpm
RUN rm  -fr UnlimitedJCEPolicyJDK8


ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
ENV JAVA_HOME /usr/java/jdk1.8.0_51

COPY mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY settings-docker.xml $USER_HOME_DIR/.m2/
RUN cp -a $USER_HOME_DIR/.m2/settings-docker.xml  $USER_HOME_DIR/.m2/settings.xml
#复制脚本
RUN mkdir -p ／opt/jar/release  \
    && mkdir -p /opt/jar/source \
    && mkdir -p /opt/logs  \
    && mkdir -p /opt/script 

COPY script/* /opt/script/
COPY jar/* /opt/jar/

#git  下啦文件准备
RUN echo "https://zhen286339409:zz286339409@git.coding.net"  > ~/.gitconfig
RUN git config --global credential.helper store 

RUN chmod +x  /usr/local/bin/mvn-entrypoint.sh
VOLUME "$USER_HOME_DIR/.m2"


ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["bash"]

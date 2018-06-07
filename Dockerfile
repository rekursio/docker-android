FROM ubuntu:latest


ENV ANDROID_HOME /opt/android
ENV PATH "${PATH}:${ANDROID_HOME}/tools"
ENV PATH "${PATH}:${ANDROID_HOME}/tools/bin"


# Install required tools
# Dependencies to execute Android builds

RUN dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  gcc \
  git \
  openjdk-8-jdk \
  wget \
  libc6:i386 \
  libstdc++6:i386 \
  zlib1g:i386 \
  unzip \
  && apt-get clean


# Download Android SDK

RUN mkdir $ANDROID_HOME
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip --directory-prefix=$ANDROID_HOME
RUN unzip $ANDROID_HOME/sdk-tools-linux-3859397.zip -d $ANDROID_HOME
RUN rm $ANDROID_HOME/sdk-tools-linux-3859397.zip

RUN mkdir ~/.android
RUN touch ~/.android/repositories.cfg


# Accept all Android SDK licenses

RUN yes | sdkmanager --licenses

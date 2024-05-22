FROM ubuntu:22.04

RUN apt update ; \
  apt install -y npm openjdk-17-jdk unzip curl ; \
  mkdir -p ~/android-sdk ; \
  cd ~/android-sdk ; \
  curl -O https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip ; \
  unzip commandlinetools-linux* ; \
  rm -f commandlinetools-linux* ; \
  mv cmdline-tools temp ; \
  mkdir -p cmdline-tools/latest ; \
  mv temp/* cmdline-tools/latest ; \
  rm -fr temp ; \
  echo 'export ANDROID_HOME=$HOME/android-sdk' >> ~/.bashrc ; \
  echo 'export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH' >> ~/.bashrc ; \
  echo 'export PATH=$ANDROID_HOME/emulator:$PATH' >> ~/.bashrc ; \
  echo 'export PATH=$ANDROID_HOME/platform-tools:$PATH' >> ~/.bashrc ; \
  . ~/.bashrc ; \
  yes | sdkmanager --sdk_root=$ANDROID_HOME "platform-tools" "platforms;android-33" "build-tools;33.0.0" "emulator" ; \
  yes | sdkmanager --licenses ; \
  cd ~ ; \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash ; \
  . ~/.bashrc ; \
  nvm install 22 ; \
  npm install -g react-native-cli ; \
  npm install -g react-native ; \
  npx react-native init MyFirstApp ; \
  cd MyFirstApp ; \
  npx react-native build-android


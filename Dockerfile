FROM openjdk:11

ENV SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip" \
    ANDROID_HOME="/usr/local/android-sdk" \
    ANDROID_VERSION=30 \
    ANDROID_BUILD_TOOLS_VERSION=30.0.2

RUN mkdir "$ANDROID_HOME" .android \
    && cd "$ANDROID_HOME" \
    && curl -o sdk.zip $SDK_URL \
    && unzip sdk.zip \
    && rm sdk.zip \
    && mkdir ${ANDROID_HOME}/cmdline-tools/latest \
    && cp -R ${ANDROID_HOME}/cmdline-tools/bin/ ${ANDROID_HOME}/cmdline-tools/latest/bin/ \
    && cp -R ${ANDROID_HOME}/cmdline-tools/lib/ ${ANDROID_HOME}/cmdline-tools/latest/lib/ \
    && yes | $ANDROID_HOME/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_HOME}/cmdline-tools/latest --licenses

RUN $ANDROID_HOME/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_HOME}/cmdline-tools/latest --update

RUN $ANDROID_HOME/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_HOME}/cmdline-tools/latest "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    "platforms;android-${ANDROID_VERSION}" \
    "platform-tools"
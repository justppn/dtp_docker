FROM debian:stable-slim

COPY . .

ENV DOTNET_CLI_TELEMETRY_OPTOUT=1 \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1 \
    DOTNET_NOLOGO=true \
    DOTNET_GENERATE_ASPNET_CERTIFICATE=false \
    DOTNET_ADD_GLOBAL_TOOLS_TO_PATH=false \
    DOTNET_MULTILEVEL_LOOKUP=0 \
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    PATH="${PATH}:/usr/bin/datareon/platform"

RUN apt update && \
    apt upgrade -y &&\
    apt install -y \
    sudo \
    wget \
    nano \
    librocksdb-dev \
    libicu-dev && \
    wget --no-check-certificate https://storage.yandexcloud.net/absgroup-storage/platform.deb && \
    dpkg -i platform.deb || true && \
    apt install -f -y && \
    wget http://ftp.de.debian.org/debian/pool/main/i/icu/libicu63_63.1-6+deb10u3_amd64.deb && \
    wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.1_1.1.1n-0+deb10u6_amd64.deb  && \
    dpkg -i libicu63_63.1-6+deb10u3_amd64.deb && \
    dpkg -i libssl1.1_1.1.1n-0+deb10u6_amd64.deb && \
    rm -f  /*.deb && \
    rm -rf /var/cache/apt && \
    rm -rf /var/lib/apt/lists && \
    chmod u+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
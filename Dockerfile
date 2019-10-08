FROM alpine:3.10

LABEL maintainer="Mahito Tanno <pb94.mahito@gmail.com>"

ARG ASPELL_VERSION="0.60.7"
ARG DICT_EN_VERSION="2019.10.06-0"
ARG DICT_FR_VERSION="0.50-3"
ARG DICT_DE_VERSION="20161207-7-0"

ARG ASPELL_SERVER="https://ftp.gnu.org/gnu/aspell"
ARG DICT_EN="aspell6-en-${DICT_EN_VERSION}"
ARG DICT_FR="aspell-fr-${DICT_FR_VERSION}"
ARG DICT_DE="aspell6-de-${DICT_DE_VERSION}"

WORKDIR /tmp

RUN set -x && \
    # Install tools
        apk update && apk add --no-cache g++ perl make && \
    # Install Aspell 
        wget -q "${ASPELL_SERVER}/aspell-${ASPELL_VERSION}.tar.gz" && \
        tar xzf "aspell-${ASPELL_VERSION}.tar.gz" && \
        cd "aspell-${ASPELL_VERSION}" && \
        ./configure && make && make install && make clean && cd /tmp && \
    # Install English dictionary
        wget -q "${ASPELL_SERVER}/dict/en/${DICT_EN}.tar.bz2" && \
        tar xjf "${DICT_EN}.tar.bz2" && \
        cd "${DICT_EN}" && \
        ./configure && make && make install && make clean && cd /tmp && \
    # Install French dictionary
        wget -q "${ASPELL_SERVER}/dict/fr/${DICT_FR}.tar.bz2" && \
        tar xjf "${DICT_FR}.tar.bz2" && \
        cd "${DICT_FR}" && \
        ./configure && make && make install && make clean && cd /tmp && \
    # Install German dictionary
        wget -q "${ASPELL_SERVER}/dict/de/${DICT_DE}.tar.bz2" && \
        tar xjf "${DICT_DE}.tar.bz2" && \
        cd "${DICT_DE}" && \
        ./configure && make && make install && make clean && cd /tmp && \
    # Clean up
        apk del --purge perl make && \
        rm -rf /tmp/* 

WORKDIR /work

ENTRYPOINT ["aspell"]
CMD ["--version"]

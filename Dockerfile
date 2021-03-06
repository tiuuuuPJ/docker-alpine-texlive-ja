# Copyright (c) 2016 Kaito Udagawa
# Copyright (c) 2016-2018 3846masa
# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM frolvlad/alpine-glibc

MAINTAINER pj

ENV PATH /usr/local/texlive/2018/bin/x86_64-linuxmusl:$PATH

RUN apk --no-cache add perl wget xz tar fontconfig-dev freetype-dev && \
    mkdir /tmp/install-tl-unx && \
    wget -qO - ftp://tug.org/historic/systems/texlive/2018/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "option_doc 0" \
      "option_src 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile && \
    tlmgr install \
      collection-basic collection-luatex \
      collection-fontsrecommended collection-langjapanese \
      etoolbox filehook fontspec xkeyval ulem listings unicode-math \
      latexmk beamer luatexja luatexbase luaotfload && \
    rm -fr /tmp/install-tl-unx && \
    apk --no-cache del xz tar

RUN apk --no-cache add bash

RUN mkdir /workdir

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["bash"]

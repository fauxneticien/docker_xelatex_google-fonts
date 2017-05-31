FROM bitnami/minideb:jessie

# Install packages (xelatex + biber + etc...)
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
    wget \
    unzip \
    make \
    git \
    ca-certificates \
    lmodern \
    texlive-latex-base \
    latex-xcolor \
    texlive-math-extra \
    texlive-latex-extra \
    texlive-bibtex-extra \
    biber \
    fontconfig \
    texlive-xetex && \
    apt-get autoclean && apt-get --purge --yes autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up Google fonts
RUN mkdir /fonts

WORKDIR /fonts

RUN wget https://github.com/google/fonts/archive/master.zip -O /fonts/master.zip && \
    unzip master.zip && \
    mkdir -p "/usr/share/fonts/truetype/google-fonts/" && \
    find /fonts/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1 && \
    fc-cache -f -v && \

WORKDIR /

RUN rm -rf /fonts

FROM pandoc/latex:3.1.1

RUN tlmgr update --self --all && \
    tlmgr install collection-langjapanese
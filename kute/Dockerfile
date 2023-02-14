FROM swift:latest

RUN git clone https://github.com/zeionara/kute.git 

RUN cd /kute/kute && swift build

ENV PORT=
ENV SEED=
ENV BARE=

ENTRYPOINT [ \
    "bash", "-c", \
    "cd /kute/kute && swift run kute serve \
    $(if [[ -z $PORT ]]; then echo ''; else echo '--port '$PORT; fi) \
    $(if [[ -z $SEED ]]; then echo ''; else echo '--seed '$SEED; fi) \
    $(if [[ -z $BARE ]]; then echo ''; else echo '--bare'; fi)" \
]

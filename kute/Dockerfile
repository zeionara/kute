FROM swift:latest

RUN git clone https://github.com/zeionara/kute.git 

RUN cd /kute/kute && swift build

ENV PORT=8080
ENV SEED=17

ENTRYPOINT cd /kute/kute && swift run kute serve --port $PORT --seed $SEED

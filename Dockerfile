FROM percona/percona-server-mongodb

RUN mkdir -p /home/app

COPY . /home/app

CMD["percona","/backend/src/app.ts"]
FROM postgres:10.10
ENV POSTGISV 2.4
ENV TZ America/Bogota
# Instalaciones
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  postgresql-$PG_MAJOR-postgis-$POSTGISV \
  postgresql-$PG_MAJOR-postgis-$POSTGISV-scripts \
  postgresql-$PG_MAJOR-pgrouting \
  postgresql-$PG_MAJOR-pgrouting-scripts \
  postgresql-server-dev-$PG_MAJOR \
  unzip \
  make \
  && apt-get purge -y --auto-remove postgresql-server-dev-$PG_MAJOR make unzip

# set time zone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# add init script
RUN mkdir -p /docker-entrypoint-initdb.d
# copia dentro el init y el new_config
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh
COPY ./new_conf.sh /docker-entrypoint-initdb.d/new_conf.sh

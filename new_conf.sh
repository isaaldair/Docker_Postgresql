#!/bin/sh
# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/data/pg_hba.conf
echo "host all  all    192.168.10.119/32  md5" >> /var/lib/postgresql/data/pg_hba.conf
echo "host all  all    192.168.10.100/32  md5" >> /var/lib/postgresql/data/pg_hba.conf
echo "host all  all    192.168.10.1/32    md5" >> /var/lib/postgresql/data/pg_hba.conf
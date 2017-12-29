#!/bin/bash

cd /opt/oracle/scripts/setup/apex
echo "Installing APEX in plugable database: $ORACLE_PDB"
echo "ORACLE PASSWORD FOR APEX_PUBLIC_USER, APEX_LISTENER, APEX_REST_PUBLIC_USER: $ORACLE_PWD"

sqlplus /nolog <<EOF
connect / as sysdba
alter session set container = $ORACLE_PDB;
create tablespace apex_ts datafile 'apex_ts.dat' size 1G autoextend on;
@apexins.sql apex_ts apex_ts temp /i/
EOF

sqlplus /nolog <<EOF
connect / as sysdba
alter session set container = $ORACLE_PDB;
alter user apex_public_user identified by $ORACLE_PWD account unlock;
@apex_rest_config_core.sql $ORACLE_PWD $ORACLE_PWD
EOF
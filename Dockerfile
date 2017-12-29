FROM oracle/database:12.2.0.1-se2

USER oracle:oinstall 

COPY --chown=oracle:oinstall apex.current.zip ./apex.current.zip

RUN unzip -q apex.current.zip && \
	mv apex /opt/oracle/scripts/setup/

COPY --chown=oracle:oinstall installApex.sh ./installApex.sh

RUN chmod +x ./installApex.sh && \
	mv installApex.sh /opt/oracle/scripts/setup/01_installApex.sh

ENV ORACLE_BASE=/opt/oracle \
	RUN_FILE=runOracle.sh

ENTRYPOINT ["sh","-c","$ORACLE_BASE/$RUN_FILE"]

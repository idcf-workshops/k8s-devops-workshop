FROM openjdk:8-jre-alpine

ARG JARFILENAME
ENV JARFILE=$JARFILENAME

WORKDIR /app
# build context set to module dir
COPY ./target/$JARFILENAME /app/

ENTRYPOINT ["/bin/sh", "-c", "java -jar ./${JARFILE}"]
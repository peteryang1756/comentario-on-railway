FROM registry.gitlab.com/comentario/comentario

COPY secrets.template.yaml .

RUN apk add --no-cache envsubst

ARG POSTGRES_HOST
ARG POSTGRES_PORT
ARG POSTGRES_DATABASE
ARG POSTGRES_USERNAME
ARG POSTGRES_PASSWORD

RUN envsubst < secrets.template.yaml > secrets.yaml
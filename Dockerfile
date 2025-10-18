FROM registry.gitlab.com/comentario/comentario

COPY secrets.template.yaml .

RUN apk add --no-cache envsubst

RUN envsubst < secrets.template.yaml > secrets.yaml
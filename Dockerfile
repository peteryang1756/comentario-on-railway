FROM registry.gitlab.com/comentario/comentario

COPY secrets.template.yaml .

RUN envsubst < secrets.template.yaml > secrets.yaml
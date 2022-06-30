FROM python:3.9
LABEL maineiner="Erna Tercero"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

COPY . /app 


WORKDIR /app
EXPOSE 8000

ARG DEV=true

RUN pip install --upgrade pip && \
    pip install pipenv  && \
    pipenv install --system && \
    pip install -r /tmp/requirements.txt && \
    if [$DEV = "true"]; \
    then pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"

USER django-user


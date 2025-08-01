FROM python:alpine

RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add postgresql-dev \
    && apk add jpeg-dev zlib-dev libjpeg libffi-dev

# ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1
ENV  PYTHONUNBUFFERED=1
EXPOSE 8000

WORKDIR /app
COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt
COPY . /app/
RUN chmod +x entrypoint.sh
RUN python manage.py makemigrations
RUN python manage.py migrate
# ENTRYPOINT [ "./entrypoint.sh" ]
# CMD ["python3", "./manage.py", "runserver"]
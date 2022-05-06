FROM python:3.10-alpine

ENV PATH="/scripts:${PATH}"

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers
RUN pip install -r /requirements.txt
RUN apk del .tmp

RUN mkdir /django-portfolio
COPY ./personal_portfolio /django-portfolio
WORKDIR /django-portfolio
COPY ./scripts /scripts


RUN chmod +x /scripts/*


RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/staticfiles

RUN adduser -D user
RUN chown -R user:user /vol
RUN chmod -R 755 /vol/web
RUN chmod -R 777 /django-portfolio/staticfiles
USER user

CMD ["entrypoint.sh"]

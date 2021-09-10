FROM python:3.8
LABEL maintainer="Marco Schlicht <git@privacymail.dev>"

ENV PYTHONPATH=src
ENV PYTHONUNBUFFERED=1
ENV HOST=0.0.0.0
ENV PORT=5001
ENV LOCALDEVMODE=False

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5001

CMD [ "python", "-m", "lab_orchestrator_ws_proxy" ]
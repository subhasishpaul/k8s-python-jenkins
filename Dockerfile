FROM python:3.7.3-alpine3.9

RUN mkdir -p /app
WORKDIR /app

COPY ./src/requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

COPY ./src/ /app/
ENV FLASK_APP=server.py

###########START NEW IMAGE : DEBUGGER ###################
# FROM base as debug
# RUN pip install ptvsd

# WORKDIR /work/
# CMD python -m ptvsd --host 0.0.0.0 --port 5678 --wait --multiprocess -m flask run -h 0.0.0.0 -p 5000


###########START NEW IMAGE: PRODUCTION ###################
# FROM base as prod

CMD flask run -h 0.0.0.0 -p 5000

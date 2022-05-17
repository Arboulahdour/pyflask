FROM python:3

ADD . /python-flask

WORKDIR /python-flask

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python3", "app.py"]

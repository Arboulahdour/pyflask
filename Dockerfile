FROM python:3

ADD . /python-flask

WORKDIR /python-flask

RUN pip install -r requirements.txt

EXPOSE 80

CMD ["python3", "main.py"]

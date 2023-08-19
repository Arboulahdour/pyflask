FROM python:3

ADD . /pyflask

WORKDIR /pyflask

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python3", "app.py"]

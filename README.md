# Pyflask Application 

The purpose of this lab is to show you how to get a Python-Flask application into a Docker container. 
We will build a Docker image of a simple web application in Python, then we will deploy it as container from the created image on developement server.

## Prerequisites
- Python
- Docker
- Make

## Install Docker Engine

Docker Engine is available on a variety of Linux platforms, macOS and Windows 10 through Docker Desktop, and as a static binary installation. Please follow the Docker [official document](https://docs.docker.com/engine/install/)  for Docker Installation.

## Building the Docker image

I have already developed the Dockerfile and python app and it is provided below,

### python app

~~~sh
from flask import Flask, jsonify

app = Flask(__name__)


@app.route('/')
def index():
    return jsonify({'Python': 'Flask Application v0.1.0 !!!'})


if __name__ == '__main__':
    app.run(host="0.0.0.0", port="5000", debug=True)
~~~

### Dockerfile

~~~sh
FROM python:3

ADD . /pyflask

WORKDIR /pyflask

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python3", "app.py"]
~~~

Please perform the steps below to clone the github repository;

~~~sh
apt install git -y
git clone https://github.com/Arboulahdour/pyflask.git
~~~ 

Go to the directory and run the following command to build the Docker image. The -t flag lets you tag your image so it's easier to find later using the docker images command:
~~~sh
cd pyflask/
docker build -t <your username>/pyflask:0.1.0 . 

or

make build
~~~

Your image will now be listed by Docker using the command:
~~~sh
docker image ls
~~~

Now run the container from the Image created:
~~~sh
docker container run --name pyflask -p 5000:5000 -d arboulahdour/pyflask:0.1.0

or

make deploy

~~~

To test your app, get the port of your app that Docker mapped:
~~~sh
docker container ls
~~~

In the example above, Docker mapped the 5000 port inside of the container to the port 5000 on your machine.

Now you can test your app using curl or access the server IP through web browser
~~~sh
curl -I http://SERVER-IP:5000
~~~

You can also push this image to Docker Hub repositories

[Docker Hub repositories](https://docs.docker.com/docker-hub/repos/) allow you to share container images with your team, customers, or the Docker community at large.

I have uploaded this Container Image to docker hub and you can download the image by

~~~sh
docker pull arboulahdour/pyflask:0.1.0
~~~

## Author
Created by @Arboulahdour

<a href="mailto:ar.boulahdour@outlook.com">E-mail me !</a>

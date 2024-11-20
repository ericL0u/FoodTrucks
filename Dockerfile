# start from base
FROM ubuntu:18.04

LABEL maintainer="Prakhar Srivastav <prakhar@prakhar.me>"

# install system-wide deps for python and node
#old install python 3.6?

RUN apt-get -yqq update
RUN apt-get -yqq install python3-pip python3-dev curl libffi-dev libssl-dev gnupg

# Install Python 3.8 and system dependencies
# RUN apt-get update && apt-get install -y \
#     python3.8 python3.8-dev python3-pip \
#     build-essential \
#     libffi-dev \
#     libssl-dev \
#     gcc \
#     curl \
#     gnupg

# Set Python 3.8 as default
# RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
# RUN update-alternatives --config python3

RUN pip3 install --upgrade pip
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install -yq nodejs

# RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash && apt-get install -yq nodejs
# RUN node -v && npm -v


# copy our application code
ADD flask-app /opt/flask-app
WORKDIR /opt/flask-app

# fetch app specific deps
RUN npm install
RUN npm run build
RUN pip3 install -r requirements.txt

# expose port
EXPOSE 5000

# start app
CMD [ "python3", "./app.py" ]

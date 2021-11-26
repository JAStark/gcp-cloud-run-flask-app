# use python39
From python:3.9

# copy requirements.txt to the docker image and install packages
COPY requirements.txt /
RUN pip install -r requirements.txt
RUN python -m pip install --upgrade pip

# set the WORKDIR to be the folder
COPY . /app

# expose port 5000
EXPOSE 5000
ENV PORT 5000

WORKDIR /app

# use gunicorn as the entrypoint
CMD exec gunicorn --bind :$PORT main:app --workers 1 --threads 1 --timeout 60

FROM python:3.8.6-slim-buster

# it installs all for packages building
RUN apt-get update && apt-get install -y \
    build-essential \
    automake \
    autoconf \
    libboost-program-options-dev \
    zlib1g-dev \
    gfortran \
    libopenblas-dev \
    liblapack-dev \
    libpq-dev \
    python-dev \
    python-psycopg2

# create base folder
ARG BASE_FOLDER
WORKDIR $BASE_FOLDER

# it installs python pakages

COPY requirements.txt $BASE_FOLDER/
RUN pip3.8 install --no-cache-dir -r $BASE_FOLDER/requirements.txt

#download to $NLTK_DATA
ARG NLTK_DATA
RUN mkdir -p $NLTK_DATA
RUN python3.8 -m nltk.downloader universal_tagset \
    maxent_treebank_pos_tagger \
    stopwords \
    porter_test \
    wordnet

ARG DATA_STORAGE_PATH
ARG JUPYTER_ROOT_USER
ARG JUPYTER_ROOT_USER_HOME
ARG JUPYTER_ROOT_USER_UID
ARG JUPYTER_TOKEN
ARG JUPYTER_USERS
ARG JUPYTER_USERS_GROUP
ARG JUPYTER_USERS_GROUP_GID

# it marks bash as docker container
RUN echo 'export PS1="\e[1;34m\u@docker \w> \e[m"' >> ~/.bashrc
RUN echo 'export TERM=xterm' >> ~/.bashrc

# it adds Jupiter root user
RUN groupadd --gid $JUPYTER_USERS_GROUP_GID $JUPYTER_USERS_GROUP
RUN useradd -m --uid $JUPYTER_ROOT_USER_UID $JUPYTER_ROOT_USER

# it adds users from outside of container, it allows to Jupiter 
# read and write a real users data from mounted volumes

COPY add_user.sh $BASE_FOLDER
COPY docker-entrypoint.sh $BASE_FOLDER/
RUN $BASE_FOLDER/add_user.sh
RUN mkdir -p $DATA_STORAGE_PATH

# it changes users right
RUN usermod -a -G $JUPYTER_USERS_GROUP $JUPYTER_ROOT_USER
RUN usermod -g $JUPYTER_USERS_GROUP $JUPYTER_ROOT_USER
RUN chown -R $JUPYTER_ROOT_USER:$JUPYTER_USERS_GROUP $DATA_STORAGE_PATH
RUN chown -R $JUPYTER_ROOT_USER:$JUPYTER_USERS_GROUP $JUPYTER_ROOT_USER_HOME
RUN chown -R $JUPYTER_ROOT_USER:$JUPYTER_USERS_GROUP $BASE_FOLDER

# it starts server
RUN ls -la ./

USER $JUPYTER_ROOT_USER
RUN jupyter contrib nbextension install --user && jupyter nbextensions_configurator enable --user

ENTRYPOINT ["./docker-entrypoint.sh"]

#Dockerfile
from ruby-3.4.3

# Define o ambiente não interativo para evitar prompts durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y
RUN apt install lsb-base lsb-release

# Postgress
# Import the repository signing key:
RUN apt install curl ca-certificates
RUN install -d /usr/share/postgresql-common/pgdg
RUN curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc

# Create the repository configuration file:
RUN . /etc/os-release
RUN sh -c "echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $VERSION_CODENAME-pgdg main' > /etc/apt/sources.list.d/pgdg.list"

# Update the package lists:
RUN apt update \
    && apt install -y libpq-dev \
    vim \
    htop \
    postgresql-14

RUN gem install pg

ADD . /home/app/web
WORKDIR /home/app/web

RUN bundle install --jobs 5 --retry 5

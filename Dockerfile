FROM ubuntu

# Install Conda

RUN apt-get update \
    && apt-get install -y wget \
    && wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh \
    && echo "export PATH=/opt/conda/bin:$PATH" >> ~/.bashrc \
    && /opt/conda/bin/conda init bash

# Install Linux dependencies
RUN apt-get install -y make zlib1g-dev gcc g++ python3-pip

# Docker in docker setup
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo \
      "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli

VOLUME /var/run/docker.sock:/var/run/docker.sock    

ENV DOCKER_HOST=unix:///var/run/docker.sock

# Set up Conda environment
COPY environment.yml /
RUN /opt/conda/bin/conda env create -f /environment.yml && \
    /opt/conda/bin/conda clean -afy
ENV PATH /opt/conda/envs/my_env/bin:$PATH

# Install pip dependencies
COPY requirements.txt /
RUN pip install -r /requirements.txt --no-cache-dir

COPY . .

ENTRYPOINT ["/opt/conda/bin/conda", "run", "--no-capture-output", "-n", "meta", "python3", "Main.py"]
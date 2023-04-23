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
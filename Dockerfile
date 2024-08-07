# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

FROM quay.io/jupyter/base-notebook

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Install all OS dependencies for fully functional notebook server
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    # Common useful utilities
    git \
    nano-tiny \
    tzdata \
    unzip \
    vim-tiny \
    # Inkscape is installed to be able to convert SVG files
    inkscape \
    # git-over-ssh
    openssh-client \
    # less is needed to run help in R
    # see: https://github.com/jupyter/docker-stacks/issues/1588
    less \
    # nbconvert dependencies
    # https://nbconvert.readthedocs.io/en/latest/install.html#installing-tex
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-plain-generic && \
    rm -rf /home/jovyan/work && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    pip install ipcalc

# Create alternative for nano -> nano-tiny
RUN update-alternatives --install /usr/bin/nano nano /bin/nano-tiny 10

ENTRYPOINT ["tini", "-g", "--"]
CMD start-notebook.sh --NotebookApp.token="" --NotebookApp.allow_origin="*"

COPY start-notebook.sh /usr/local/bin/

ADD sdk.tar.gz /home/jovyan/

RUN fix-permissions /usr/local/bin/ && \
	fix-permissions /home/jovyan/

# Switch back to jovyan to avoid accidental container runs as root
USER ${NB_UID}

WORKDIR "${HOME}"

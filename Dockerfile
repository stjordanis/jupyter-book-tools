FROM ubuntu:cosmic

# do not prompt
ARG DEBIAN_FRONTEND=noninteractive

# system package install
# optional: texlive-fonts-extra 
RUN apt-get -y update && \
    apt-get -y install ca-certificates python3 python3-pip \
	    texlive-latex-base texlive-latex-extra texlive-fonts-recommended \
		pandoc && \
    apt-get autoclean && apt-get --purge --yes autoremove && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# jupyter layer
RUN pip3 install jupyter nbmerge

# /book is the mount point
RUN mkdir /book 

COPY genbook /usr/bin/genbook
COPY welcome /usr/bin/welcome
COPY booktemplate.tplx /etc/booktemplate.tplx

WORKDIR /book

CMD ["/usr/bin/welcome"]


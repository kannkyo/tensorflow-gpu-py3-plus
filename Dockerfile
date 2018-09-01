FROM tensorflow/tensorflow:latest-gpu

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# install packages
RUN apt-get -y update --fix-missing && \
    apt-get install -y \
	git \
	software-properties-common \
	vim \
	bzip2 \
	python3-pip \
	curl \
	wget \
	unzip \
	libmecab-dev \
	libc6-dev \
	libssl-dev \
	libreadline-dev \
	mecab \
	mecab-ipadic \
	mecab-ipadic-utf8 \
	zlib1g-dev \
	apt-utils \
	software-properties-common \
	sudo \
	net-tools \
	libssl-dev \
	build-essential

# install pip packages
RUN pip install --upgrade pip 
RUN pip install \
	beautifulsoup4 \
	requests \
	pyyaml \
	opencv-python \
	openpyxl \
	xlrd \
	tinydb \
	scikit-learn \
	scikit-image \
	keras \
	janome \
	google_images_download \
	gensim \
	mecab-python3

# install ruby
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
RUN /bin/bash -c "source ~/.bash_profile"
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH
RUN rbenv install 2.5.1
RUN rbenv global 2.5.1

# install wp2txt
RUN gem install wp2txt

# clean 
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*


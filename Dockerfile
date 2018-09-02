FROM tensorflow/tensorflow:latest-gpu-py3

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# install packages
RUN apt-get -y update --fix-missing && \
    apt-get install -y \
	apt-utils \
	build-essential \
	bzip2 \
	cmake \
	curl \
	git \
	libmecab-dev \
	libc6-dev \
	libssl-dev \
	libreadline-dev \
	libssl-dev \
	libsm6 \
	libxrender1 \
	mecab \
	mecab-ipadic \
	mecab-ipadic-utf8 \
	net-tools \
	python3-pip \
	software-properties-common \
	sudo \
	unzip \
	vim \
	wget \
	zlib1g-dev

# install pip packages
RUN pip install --upgrade pip 
RUN pip install \
	atari-py \
	beautifulsoup4 \
	dopamine-rl \
	gensim \
	google_images_download \
	janome \
	keras \
	mecab-python3 \
	opencv-python \
	openpyxl \
	pyyaml \
	requests \
	scikit-learn \
	scikit-image \
	tinydb \
	xlrd

# reinstall tensorflow because of gpu support
RUN pip uninstall -y tensorflow tensorflow-gpu
RUN pip install tensorflow-gpu

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


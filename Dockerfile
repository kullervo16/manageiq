FROM centos:7

MAINTAINER Jef Verelst
#inspired by http://manageiq.org/community/install-from-source/

RUN yum -y install http://dl.fedoraproject.org/pub/epel/6Server/x86_64/epel-release-6-8.noarch.rpm

RUN yum -y install git libxml2-devel libxslt libxslt-devel sudo
RUN yum -y install postgresql-server postgresql-devel memcached ruby-devel gcc-c++
RUN yum -y install tar

RUN command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
RUN curl -sSL https://get.rvm.io | rvm_tar_command=tar bash -s stable
RUN /usr/local/rvm/bin/rvm install 2.0.0
RUN gem install bundler -v "~>1.3"

RUN git clone https://github.com/ManageIQ/manageiq

WORKDIR manageiq/vmdb
RUN bundle install --without qpid
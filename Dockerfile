FROM centos/postgresql

MAINTAINER Jef Verelst, https://github.com/kullervo16
#inspired by http://manageiq.org/community/install-from-source/

RUN yum -y install git libxml2-devel libxslt libxslt-devel sudo tar
RUN yum -y install postgresql-devel memcached ruby-devel gcc-c++

RUN command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
RUN curl -sSL https://get.rvm.io | rvm_tar_command=tar bash -s stable
RUN /usr/local/rvm/bin/rvm install 2.0.0
RUN gem install bundler -v "~>1.3"

RUN git clone https://github.com/ManageIQ/manageiq

WORKDIR manageiq/vmdb
RUN bundle install --without qpid
WORKDIR ..
RUN vmdb/bin/rake build:shared_objects
WORKDIR vmdb
RUN bundle install --without qpid

RUN cp config/database.pg.yml config/database.yml
COPY startDB.sh /
COPY createDB.sh /
WORKDIR /
RUN chmod +x startDB.sh
RUN chmod +x createDB.sh
RUN /startDB.sh

EXPOSE 3000 4000
COPY launchManageIQ.sh /
RUN chmod +x /launchManageIQ.sh
CMD /launchManageIQ.sh

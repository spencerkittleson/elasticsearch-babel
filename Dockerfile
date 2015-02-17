############################################################
# Dockerfile to build ElasticSearch container images
# with support additional languages
############################################################

FROM dockerfile/java:oracle-java8

MAINTAINER Corey Coto <corey.coto@gmail.com>

ENV ES_PKG_NAME elasticsearch-1.4.3

# Install Elasticsearch.
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Inquisitor
RUN /elasticsearch/bin/plugin install polyfractal/elasticsearch-inquisitor

# ICU Analysis
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-icu/2.4.2

# Japanese (kuromoji) Analysis
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-kuromoji/2.4.2

# Smart Chinese Analysis
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-smartcn/2.4.3

# Polish Analysis
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-stempel/2.4.2

# Russian Morphological Analysis
RUN /elasticsearch/bin/plugin -install analysis-morphology -url http://dl.bintray.com/content/imotov/elasticsearch-plugins/org/elasticsearch/elasticsearch-analysis-morphology/1.2.0/elasticsearch-analysis-morphology-1.2.0.zip

# Korean Analysis (https://github.com/jaeyoi/elasticsearch-analysis-korean)
RUN /elasticsearch/bin/plugin -install elasticsearch-analysis-korean -url https://dl.dropboxusercontent.com/u/7378689/elasticsearch-analysis-korean-1.2.0.zip

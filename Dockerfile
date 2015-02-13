############################################################
# Dockerfile to build ElasticSearch container images
# with support additional languages
############################################################

FROM dockerfile/elasticsearch
MAINTAINER Corey Coto <corey.coto@gmail.com>

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Inquisitor
RUN /elasticsearch/bin/plugin install polyfractal/elasticsearch-inquisitor

# ICU Analysis
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-icu/2.4.1

# Japanese (kuromoji) Analysis
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-kuromoji/2.4.1

# Smart Chinese Analysis
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-smartcn/2.4.2

# Polish Analysis
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-stempel/2.4.1

# Elasticsearch Runner for Kibana Objects

Put your index patterns, searches, visualizations, and dashboards in their respective directories. Only accepts ```.json``` files to curl into Elasticsearch and skips directories without them. 

Make sure to change the ```ELASTICSEARCH``` and ```KIBANA_INDEX``` environment variables. The variable for Elasticsearch should include the port as well as the host name. 

## Kubernetes

If you're using this image in a Kubernetes Pod, you can mount configmaps containing your ```.json``` files to the following directories:
- /etc/patterns/
- /etc/searches/
- /etc/visualizations/
- /etc/dashboards/

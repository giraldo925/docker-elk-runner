# ELK Stack Runner for Kibana Objects

Put your index patterns, searches, visualizations, and dashboards in their respective directories. Only accepts ```.json``` files to curl into Kibana API and skips directories without them. 

Make sure to change the ```KIBANA``` environment variable. Be sure to include the port as well as the host name. 

**Tested using ELK stack 6.3.0**

## Kubernetes

If you're using this image in a Kubernetes Pod, you can mount configmaps containing your ```.json``` files to the following directories:
- /etc/patterns/
- /etc/searches/
- /etc/visualizations/
- /etc/dashboards/

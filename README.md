# Cradlepoint Extensibility Lab

![image](https://user-images.githubusercontent.com/127797701/227977662-e65b110e-abe7-4029-b021-dbd30863b96c.png)

### Purpose:
This image runs a JupyterLab (Notebooks) web interface on http://192.168.0.2:8888  
> You can change network configuration if needed.  

It contains guided labs for learning the NCOS SDK, NCM API, and Container Orchestration platforms.   
It can take 10-15 minutes to download and start.  

### Setup Container:
Create a new container project on your Cradlepoint router and enter the following into the project compose tab:  

```yaml
version: '2.4'  
services:  
  ext:  
    image: 'cpcontainer/extensibility'  
    networks:
      lannet:
        ipv4_address: 192.168.0.2
    volumes:  
     - ${CONFIG_STORE}  
     - 'shared-data:/home/jovyan'
volumes:  
  shared-data:  
    driver: local
networks:
  lannet:
    driver: bridge
    driver_opts:
      com.cradlepoint.network.bridge.uuid: 00000000-0d93-319d-8220-4a1fb0372b51
    ipam:
      driver: default
      config:
        - subnet: 192.168.0.0/24
          gateway: 192.168.0.1
```
### Usage:
#### From Netcloud Manager:
> Create a Remote Connect LAN Manager profile for "Extensibility Lab" to connect to 192.168.0.2 port 8888 HTTP.  
> Connect to your new profile.  

#### Locally:  
> http://192.168.0.2:8888 

### Docker homepage:  
https://hub.docker.com/r/cpcontainer/extensibility

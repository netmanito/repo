#	INTRODUCCIÓNEn este documento se detalla el procedimiento de instalación de la aplicación Elasticsearch + Logstash + Kibana sobre Linux en una sola máquina.## 	ObjetivoInstalar un servicio elasticsearch escalable desde 0 en maquina física o virtual.Para entornos de producción se aconseja la instalación en más de una máquina para tener balanceo y redundancia en los datos.
Se aconsejan un mínimo de 3 nodos elasticsearch en modo **Master**, así como 3 nodos en modo **data node** para mantener el quorum y la redundancia en el servicio y datos.
En el documento se explicará cómo añadir un segundo nodo elastic o más. ## PROCEDIMIENTOLa instalación del aplicativo Elasticsearch se basa en la versión 6.1 sobre la plataforma RedHat Linux 7 / Centos 7.### Requisitos para la ejecuciónLos requisitos básicos necesarios para esta arquitectura son:-	Plataforma Linux 7 versión de instalación minimal. -	Conectividad con el repo de Elastic.co -	Conectividad a repositorios CentOS y EPEL.-	Java JDK versión 8 -	Creación de Filesystem extensible en /var/lib/elasticsearch para el almacenamiento de los datos del servicio.-	Publicación de los puertos 9200 y 9300 por TCP ### Referenciashttps://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html## INSTALACIÓN En los siguientes puntos se procede a describir de manera detallada los principales pasos para la instalación del servicio Elasticsearch.Antes de instalar el correspondiente RPM, hay que asegurarse que el comando yum funciona, ya que la instalación de paquetes se realiza a través de ‘yum install PACKAGE’### Actualización de sistema operativoActualizar el sistema actual lanzando:	# yum updateDesactivar el firewall:	# service iptables stop	# chkconfig iptables off Editar el fichero etc/selinux/config, asegurando que el flag SELINUX se encuentra “permissive”:	SELINUX = permissiveUna vez realizado el cambio, reiniciar el servidor o lanzar el siguiente comando como ‘root’:	# reboot 			
ó	# setenforce PermissiveAl final, es necesario hacer un update de todos los paquetes: (y aceptar las claves de public-yum.oracle.com	# yum -y updateFinalmente, reiniciar el servidor:	# reboot### Instalación Elasticsearch##### 1. Es necesario tener instalado java versión 8 en la máquina que vaya a incluir Elasticsearch.
	yum -y install java-1.8.0-openjdk.x86_64Para añadir el repositorio de elasticsearch hay que realizar los siguientes pasos:##### 2.	Importamos la clave GPG para poder utilizar los repositorios rpm.	rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch##### 3.	Añadir los datos del repositorio en el directorio /etc/yum.repos.d/ el arcchivo  elas-ticsearch.repo con la siguiente información:	[elasticsearch-6.x]
	name=Elasticsearch repository for 6.x packages
	baseurl=https://artifacts.elastic.co/packages/6.x/yum
	gpgcheck=1
	gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
	enabled=1
	autorefresh=1
	type=rpm-md##### 3.	Para la instalación de elasticsearch, si se hace desde el repositorio:	# yum -y install elasticsearchUna vez instalado aparece el siguiente mensaje que indica que la aplicación no está arrancada y los pasos a realizar para ello:	### NOT starting on installation, please execute the following statements to configure elasticsearch service to start automatically using systemd	 sudo systemctl daemon-reload
	 sudo systemctl enable elasticsearch.service### ATENCIÓN: Elasticsearch funciona con java JDK, tanto se puede usar OracleJDK como OpenJDK, pero siempre habrá que mantener la misma versión u 8 en todos los nodos.
Los requisitos, actualización de SO y consideraciones se mantienen para ambas versiones.#### Directorios y archivos de ElasticsearchElasticsearch instalado con RPM reparte sus archivos en los diferentes lugares:	/etc/elasticsearch/ directorio archivos de configuración 

Dentro del directorio encontramos los siguientes archivos:

	[root@node01 ~]# ls -las /etc/elasticsearch/
	total 24
	0 drwxr-xr-x    3 root elasticsearch  115 nov 18 13:08 .
	12 drwxr-xr-x. 119 root root          8192 ene 18 09:44 ..
	4 -rw-r--r--    1 root root          4093 nov 18 12:45 elasticsearch.yml
	4 -rw-r--r--    1 root root          2672 nov 18 12:46 jvm.options
	4 -rw-r--r--    1 root root          3988 nov 18 13:02 log4j2.properties
	0 drw-r--r--    2 root elasticsearch    6 jun 30  2016 scriptsEl archivo **elasticsearch.yml** contiene la configuración del nodo, los parámetros básicos para la configuración de 1 nodo único se detallan a continuación.
	[root@node01 ~]# cat /etc/elasticsearch/elasticsearch.yml |egrep -v "^#|^$" 
	cluster.name: mycluster
	node.name: node01
	node.master: true
	node.data: true
	path.data: /var/lib/data/elasticsearch
	path.repo: "/var/lib/data/backups" 
	network.host: 0.0.0.0

El archivo **jvm.options** permite configurar elementos de java como la memoria y otros. Si queremos modificar la memoria RAM  asignada a elasticsearch lo haremos en los siguientes elementos, por ejemplo para 512MB.

	-Xms512m
	-Xmx512m

Otros archivos y directorios se detallan a continuación		/etc/sysconfig/elasticsearch archivo variables de entorno 	/etc/init.d/elasticsearch archivo arranque/parada del servicio 	/usr/share/elastcisearch/ directorio, contiene binarios, librerías, plugins de la aplicación	/var/lib/elasticsearch/ directorio, contiene los datos que elasticsearch almacena, ha de ser un filesystem independiente tener los datos aislados del resto de la máquina.	/var/log/elastcisearch directorio contiene los logs de registro de la aplicación.Una vez instalado, hay que modificar unos campos en el archivo **elasticsearch.yml**.Primero haremos un backup del archivo 	# cp /etc/elasticsearch/elasticsearch.yml{,.orig}Luego cambiamos los siguientes campos, donde node.name será el nombre del equipo o nodo:	cluster.name: mycluster	node.name: node0	network.host: 0.0.0.0**network.host** indica la IP por la que va a escuchar el servicio. Si ponemos 0.0.0.0 escuchará en todas las interfaces que tenga activas la máquina.Una vez configurado, ya se puede arrancar elasticsearch con el comando 	# systemctl start elasticsearch	* Starting Elasticsearch Server	...done.Para comprobar si está funcionando tenemos varias opciones:Revisar si está activo el servicio con:	# systemctl status –l elasticsearch	● elasticsearch.service - Elasticsearch	Loaded: loaded (/usr/lib/systemd/system/elasticsearch.service; disabled; vendor preset: disabled)	Active: active (running) since mié 2016-07-13 10:02:09 CEST; 1 day 23h ago     Docs: http://www.elastic.co	Process: 28588 ExecStartPre=/usr/share/elasticsearch/bin/elasticsearch-systemd-pre-exec (code=exited, status=0/SUCCESS)	Main PID: 28590 (java)	CGroup: /system.slice/elasticsearch.service           └─28590 /bin/java -Xms256m -Xmx1g -Djava.awt.headless=true -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+HeapDumpOnOutOfMemoryError -XX:+DisableExplicitGC -Dfile.encoding=UTF-8 -Djna.nosys=true -Des.path.home=/usr/share/elasticsearch -cp /usr/share/elasticsearch/lib/elasticsearch-2.3.4.jar:/usr/share/elasticsearch/lib/* org.elasticsearch.bootstrap.Elasticsearch start -Des.pidfile=/var/run/elasticsearch/elasticsearch.pid -Des.default.path.home=/usr/share/elasticsearch -Des.default.path.logs=/var/log/elasticsearch -Des.default.path.data=/var/lib/elasticsearch -Des.default.path.conf=/etc/elasticsearchComprobar si los puertos están levantados. Por defecto los puertos 9200(HTTP) y 9300(unicast)	# netstat –antp |grep LISTEN	tcp        0      0 0.0.0.0:9200            0.0.0.0:*               LISTEN      28590/java	tcp        0      0 0.0.0.0:9300            0.0.0.0:*               LISTEN      28590/javaComprobar mediante curl si el cluster está activo. 	# curl http://localhost:9200/_cluster/health?pretty	{	"cluster_name" : "mycluster",	"status" : "green",	"timed_out" : false,	"number_of_nodes" : 3,	"number_of_data_nodes" : 2,	"active_primary_shards" : 21,	"active_shards" : 42,	"relocating_shards" : 0,	"initializing_shards" : 0,	"unassigned_shards" : 0,	"delayed_unassigned_shards" : 0,	"number_of_pending_tasks" : 0,	"number_of_in_flight_fetch" : 0,	"task_max_waiting_in_queue_millis" : 0,	"active_shards_percent_as_number" : 100.0	}Con este comando obtenemos directamente información del cluster elasticsearch.Si todo es correcto, el servicio elasticsearch se ha instalado correctamente.
#### Tipos de nodos
Existen varios modos de actuación de los nodos en elasticsearch, estos modos pueden trabajar separadamente o juntos en el mismo host.

* Master Node (nodo master que gestiona el funcionamiento del cluster elasticsearch)* Data Node (nodo de datos, donde se almacena la información que enviamos a elasticsearch)
* Ingest Node (nodo de ingesta de datos)
* Coordinator Node (Nodo que solo se conecta al cluster para hacer búsquedas en los datos)
El funcionamiento por defecto de elasticsearch en una instalación limpia es de MASTER+DATA+INGEST+COORDINATOR, donde el nodo hace todas las acciones permitidas por la aplicación. 
En función de nuestras necesidades variaremos la arquitectura para un optimo uso del producto.
Para un cluster de producción con persistencia de datos se aconseja el siguiente esquema
* 3 Master eligible Nodes (mantiene el quorum de 2+1)
* 3 Data - Ingest nodes (3 endpoints de entrada + 3 almacenamientos distribuidos para no perder datos en caso de caida)
* 1 Coordinator node (sólo hace busquedas, se conecta kibana para separarlo de la actividad del cluster)
A partir de aquí, pueden ampliarse los diferentes elementos en función de las necesidades, por ejemplo creando ingest nodes para quitar esa carga de los data nodes.### Instalación Kibana
Para poder interactuar con Elasticsearch instalaremos Kibana. 
Utilizando el mismo repositorio ejecutaremos
	yum install kibana
Una vez instalado, tendremos los siguientes archivos y directorios.
	/etc/kibana/kibana.yml archivo de configuración kibana
En este archivo indicamos el nombre del índice que va a utilizar kibana y los servidores elasticsearch a los que se va a conectar.
	[root@node01 ~]# cat /etc/kibana/kibana.yml |egrep -v "^#|^$" 
	server.port: 5601
	server.host: "0.0.0.0" 
	elasticsearch.url: "http://node01:9200" 
	kibana.index: ".kibana" 

Podemos comprobar su funcionamiento con **ps**

	[root@node01 ~]# ps aux |grep kibana
	root      3644  0.4  2.2 1263788 87696 pts/2   Sl+   2016 300:28 /usr/share/kibana/bin/../node/bin/node --no-warnings /usr/share/kibana/bin/../src/cli -c /etc/kibana/kibana.yml
	root     31821  0.0  0.0 112672   972 pts/0    S+   12:07   0:00 grep --color=auto kibana

Tambien comprobaremos que el puerto 5601 está abierto.

	# netstat –antp |grep LISTEN	tcp        0      0 0.0.0.0:9200            0.0.0.0:*               LISTEN      28590/java	tcp        0      0 0.0.0.0:9300            0.0.0.0:*               LISTEN      28590/java
	tcp        0      0 0.0.0.0:5601            0.0.0.0:*               LISTEN      26676/./bin/../node

Ahora ya podemos acceder a Kibana a través del navegador en la ruta [http://node01:5601](http://node01:5601)

Ahora ya podríamos enviar datos a Elasticsearch y podríamos verlos a través de Kibana.

### Instalación Logstash

Existen diferente métodos de enviar los datos a elasticsearch. En este documento utilizaremos Logstash como punto de recogida y parseo de la información que almacenaremos en Elasticsearch.

Instalamos por RPM

	yum install logstash
	
O nos descargamos el archivo para descomprimirlo y ejecutarlo en la consola. Es util para comenzar a probar la aplicación.

	curl -O -k https://artifacts.elastic.co/downloads/logstash/logstash-6.1.2.zip

El paquete RPM dejará los archivos de configuración en **/etc/logstash** y para los archivos de parseo **/etc/logstash/conf.d/**

En el archivo .zip, se encuentran dentro del directorio **/config**

Para ejecutar logstash desde la consola lo haremos de la siguiente manera:

	/usr/share/logstash/bin/logstash -f /path/to/file.conf

Los archivos de configuración de Logstash siguen el siguente patrón

	input {
	  file {
        type => "log"
        path => "/var/log/syslog"
	  }
	  beats {
        type => "log"
        port => "5000"
	  }
	}
	filter {
	}
	output {
	  stdout { codec => rubydebug }
	  elasticsearch {
        hosts => "node01:9200"
        index => "myindex-%{+YYYY.MM.dd}"
      }
	}Este ejemplo de configuración tiene 2 entradas en la sección **input**, el primero lee el archivo **/var/log/syslog** y el segundo abre el puerto TCP 5000 para recibir desde cualquier agente *Beats*
En la sección **filter{}** introduciremos todos los procesados que queramos hacer a los datos que recibimos.
La sección **output** es la salida de los datos procesados, en este caso tenemos 2 salidas, **stdout** que nos los mostrará en pantalla (ideal para pruebas) y **elasticsearch**, donde enviaremos a un sistema elasticsearch.
## Ingestión de Datos
Existen múltiples opciones y maneras de enviar datos a elasticearch. En nuestro caso utilizaremos logstash por el puerto 5000 con el agente BEATS de elasticsearch.
El agente Beats, se divide en varios agentes dedicados a tareas específicas.
[https://www.elastic.co/downloads/beats](https://www.elastic.co/downloads/beats)* filebeat -> para leer archivos log y enviarlos a logstash o elasticsearch 
* metribeat -> para leer información del sistema (cpu, RAM, io disk, procesos, etc.)
* winlogbeat -> agente para leer logs de windows
* packetbeat -> agente para analizar el tráfico de red## CONSIDERACIONES•	El documento sólo contempla la instalación del aplicativo elasticsearch de forma individual. No incluye información configuración en modo cluster ni optimizaciones asociadas al uso cómo cluster.•	 El funcionamiento de elasticsearch permite escalabilidad añadiendo más elasctisearch en forma de nodos.•	Un solo nodo no tiene persistencia de datos, si este cae, se pierde la información. Un cluster de elasticsearch con 2 o más nodos de datos permite persistencia en los datos si alguno de los nodos cae. Lo óptimo son 3 nodos de datos y 3 nodos en modo master.•	Sólo puede haber un nodo MASTER activo en el cluster, pero tener varios que son elegibles como tal.•	Los nodos pueden trabajar como contenedores de datos (data-node) o gestores de datos que no almacenan datos, solo los importan (ingest-node) o permiten búsquedas de éstos. Por defecto trabajan almacenando datos y en modo MASTER.•	El directorio /var/lib/elasticsearch debe tener un filesystem propio y con capacidad de  ex-tender el tamaño para albergar los datos críticos del servicio. 
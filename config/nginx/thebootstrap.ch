

upstream thebootstrap_app {
	server unix:/tmp/thebootstrap.sock fail_timeout=0;
}

server {
        listen   80;
        server_name  www.thebootstrap.ch;
        rewrite ^/(.*) http://bootstrap.ch/$1 permanent;
}

server {
	gzip on;
	gzip_http_version 1.0;
	gzip_proxied any;
	gzip_min_length 500;
	gzip_disable "MSIE [1-6]\.";
	gzip_types text/plain text/xml text/css
		   text/comma-separated-values
		   text/javascript application/x-javascript
		   application/atom+xml;

	server_name  thebootstrap.ch;

	root /srv/apps/thebootstrap/public/;

	location / {
		access_log  /var/log/nginx/thebootstrap.direct.log;
		try_files $uri @proxy;
	}

	location ~ ^/(assets)/  {  
		gzip_static on;
		expires     max;
		add_header  Cache-Control public;
	} 

	location @proxy {
		access_log  /var/log/nginx/thebootstrap.access.log;
                proxy_pass         http://thebootstrap_app;
                proxy_redirect     off;

                proxy_set_header   Host             $host;
                proxy_set_header   X-Real-IP        $remote_addr;
                proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
	}

}




upstream beta_thebootstrap_app {
	server localhost:8338;
}

server {
	server_name  beta.thebootstrap.ch;

	root /srv/apps/staging/thebootstrap/public/;

	location / {
		access_log  /var/log/nginx/beta.thebootstrap.direct.log;
		try_files $uri @proxy;
	}

	location @proxy {
		access_log  /var/log/nginx/beta.thebootstrap.access.log;
                proxy_pass         http://beta_thebootstrap_app;
                proxy_redirect     off;

                proxy_set_header   Host             $host;
                proxy_set_header   X-Real-IP        $remote_addr;
                proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
	}

}


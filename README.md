# docker-serveo-traefik-companion
The [Serveo](https://serveo.net/) self-hosted solution behind a Traefik reverse proxy

# Getting Started
First of all, you need to generate a ssh key-pair in order for Serveo server to run (so you can use the private key to connect)

```
$ git clone https://github.com/BirkhoffLee/docker-serveo-traefik-companion.git
$ cd docker-serveo-traefik-companion
$ ./generate-ssh-key.sh
```

In the meanwhile, go to `docker-compose.yml` and change your Traefik labels and stuff. The default SSH port is *1234* which obviously you will need to change. Remember to pass any traffic on that port through your firewall.

When you're done, make sure Traefik's running, and simply run the following.

```
$ docker-compose up -d
```

It should print out the below:

```
serveo_1  | 2018/07/23 02:08:35 Listening on :22...
```

If not, you're screwed. Hopefully, if yes, download the *ssh_key* generated from the script to your machine, and run the following, where `localhost:3000` is where your web application on your local machine binds to:

```
$ ssh -R YOUR_DOMAIN:80:localhost:3000 SERVER_IP_ADDR -p 1234 -i ./ssh_key
```

**NOTE: You need to explicitly define the domain. Replace YOUR_DOMAIN to your domain, obviously.** 

If something went wrong, add `-v` to enable SSH's verbose output.

Open your browser. Navigate to your domain. If everything's fine, the page's served under HTTPS, thanks to Traefik, and you should see something like this:

```
serveo_1  | 2018/07/23 02:09:19 Handshaking with 8.8.8.8
serveo_1  | 2018/07/23 02:09:19 New SSH connection from 8.8.8.8 (SSH-2.0-OpenSSH_7.6)
serveo_1  | 2018/07/23 02:09:20 Port forwarding request for wohoo.birkhoff.me:80
serveo_1  | 2018/07/23 02:09:20 HTTP forwarding started: http://wohoo.birkhoff.me -> 8.8.8.8:8896
serveo_1  | 2018/07/23 02:09:24 HTTP request; method: GET, ip: 192.168.16.8, host: wohoo.birkhoff.me, url http://wohoo.birkhoff.me/
```

Voilà!

For TLS encryption to work
### Local Environment (Minikube)

Dependencies:
- `ngrok`

1. Start the ngrok server to tunnel HTTPS traffic to the minikube cluster.

`ngrok http $LOCAL_URL:80` 

2. Update helm values `.Values.auth.hostname` with the ngrok hostname.

3. Update helm values `.Values.global.certmanager.email` with your email.

4. Edit the `/etc/hosts` file to point the local hostname to minikube's IP. 
*We have to use a local hostname otherwise ngrok will use localhost which will be resolved to 127.0.0.1 instead of Minikube's IP.*

`echo "$(minikube ip) $LOCAL_URL" | sudo tee -a /etc/hosts`

5. Edit the `/etc/hosts` file to point the ngrok hostname to minikube's IP such that the DNS resolution is done locally instead by the ngrok servers.
*(The above is a workaround) As ngrok's free version ends TLS encryption at the ngrok servers, we are currently unable to access the ngrok URL on the public internet, but we can verify that the TLS encryption is working.*

```
echo "$(minikube ip) $NGROK_URL" | sudo tee -a /etc/hosts

# verification 
echo | openssl s_client -showcerts -servername $NGROK_URL -
connect $NGROK_URL:443
```
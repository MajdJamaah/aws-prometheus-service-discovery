# aws-prometheus-service-discovery

Note that you need to install needed node exporters on the instances yourself!
This script will help you just to dynamically add targets to Prometheus based on instance tags.

1- Add a Tag with Key named prometheus and value on for instance you want to add to Prometheus, if you are using autoscaling group just add it from autoscaling side.

2- Create an EC2 role named service-discovery with an AdminAccess policy from AWS IAM.

3- Attach the service-discovery role to the Prometheus instance.

4- install awscli on Prometheus instance.
Ubuntu:
$ sudo apt install awscli

5- Clone the repo:
$ git clone https://github.com/MajdJamaah/aws-prometheus-service-discovery.git

7- Make the script executable
$ chmod +x servicediscovery.sh

6- Run the script
$ ./servicediscovery.sh {Region} {prometheus-configfile}

example: ./servicediscovery.sh eu-west-1 /etc/prometheus/prometheus.yml

7- Make it every 5 mins cron "crontab -e"
$ */5 * * * * /root/aws-prometheus-service-discovery/servicediscovery.sh eu-west-1 /etc/prometheus/prometheus.yml

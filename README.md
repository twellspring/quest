# Rearc Quest Evidence for Todd Wells

This page contains all of the evidence requested and the following narrative and `What would I improve` answer.
- [https://github.com/twellspring/quest](https://github.com/twellspring/quest)
- 


## #1 Create Git Repo:
I chose to fork the existing repo 

[github repo]( images/quest-git-repo.png "github repo")


## #2 Deploy to public cloud
Cloud native applications are usually not deployed directly to a virtual server. So for this exercise I chose to skip that deployment.

## #3 Deploy the app in a Docker container
I created a local docker container and accessed it via curl, then deployed it via terraform to ECS. (Sometimes I will manually create resources when experimenting with a new service, but for most work I choose to go directly to terraform.)

[docker]( images/quest-docker.png "docker")

After deploying to ECS and going to the root url I get an error. This appears to be an issue with the x509 package not having the Amazon root CA. Manually accessing the URL that failed gives me the secret word. I later changed the docker image from `node:slim` to `node:latest` and the root page started working.
[Error]( images/quest-error.png "Error")

[Yoda]( images/quest-yoda.png "Yoda")


## #4 Inject the Secret Word
At first I just passed in my own secret word. But after completing steps 5 & 7, I went back and passed in the real secret word.

[Sensational]( images/quest-sensational.png "Sensational")

[Secret]( images/quest-secretword.png "Secret Word")


## #5 and #7 Deploy Load Balancer, with TLS
I started by adding the load balancer in front of the ECS with TLS right from the start. Once that worked, I moved the ECS service into the private subnets.

[Load Balancer]( images/quest-loadbalanced.png "Load Balanced")


## Given more time, I would improve…


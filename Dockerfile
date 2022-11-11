FROM k8ssandra/cass-management-api:4.0.3-v0.1.37
USER root
RUN apt-get update && apt-get install sudo curl zip vim -y
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
RUN unzip awscliv2.zip 
RUN sudo ./aws/install
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
RUN echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
RUN sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN groupadd -r myuser && useradd -r -g myuser myuser
USER cassandra
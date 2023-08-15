FROM nvidia/cuda:11.7.1-devel-ubuntu22.04

ENV HOME=/root

WORKDIR $HOME

# we install sudo to use the shellscript later without complications; this allows the shellscript to be more universal
# also install ssh; client for fun, server for use
RUN apt update && apt install sudo openssh-client openssh-server -y

# set up miniconda and environments using the setup script
COPY setup.sh $HOME/setup.sh
COPY pytorch-gpu-test.py $HOME/pytorch-gpu-test.py
COPY tensorflow-gpu-test.py $HOME/tensorflow-gpu-test.py
RUN bash setup.sh

# set up and run ssh
RUN mkdir /var/run/sshd
RUN echo "root:root" | chpasswd
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
EXPOSE 22
ENTRYPOINT ["/opt/nvidia/nvidia_entrypoint.sh", "/usr/sbin/sshd", "-D"]

FROM dorowu/ubuntu-desktop-lxde-vnc

# Update and install various packages
RUN apt-get update -q && \
    apt-get install -yq wget curl git vim sudo lsb-release locales bash-completion

# Use en utf8 locales
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# Run and install ros2:foxy stuff
RUN apt-get install -y curl gnupg lsb-release
RUN curl -Ls https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
RUN sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN apt-get update
RUN apt-get install -y ros-foxy-desktop
RUN apt-get install -y python3-argcomplete

# Reset workdir to home-folder
RUN echo "source /opt/ros/foxy/setup.bash" >> /root/.bashrc
RUN set +u

# Source ros foxy setup-file
RUN /bin/bash -c "source /opt/ros/foxy/setup.bash"
RUN echo "Success installing ROS2 foxy"


# Finish colcon-common-extensions
RUN apt-get install -yq python3-pip
RUN pip3 install colcon-common-extensions

# Source again
RUN /bin/bash -c "source /opt/ros/foxy/setup.bash"

# Remove apt lists (for storage efficiency)
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /root

CMD ["bash", "-c", "source /opt/ros/foxy/setup.bash"]
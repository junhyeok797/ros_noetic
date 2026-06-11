FROM osrf/ros:noetic-desktop-full-focal
LABEL maintainer="Junhyeok Seo <jun2342@chungbuk.ac.kr>"

ENV DEBIAN_FRONTEND=noninteractive
ENV USERNAME=user
ENV USER_UID=1001
ENV USER_GID=1001

# Add the tools commonly used in ROS development, without reinstalling ROS itself.
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    gosu \
    locales \
    nano \
    wget \
    git \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Create a non-root user that can use sudo inside the container.
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} --create-home --shell /bin/bash ${USERNAME} \
    && usermod -aG sudo,dialout,video,plugdev ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

RUN mkdir -p /home/${USERNAME}/catkin_ws \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/catkin_ws

SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /home/${USERNAME}/.bashrc

COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

WORKDIR /home/user

CMD ["bash"]
FROM ubuntu:20.04
LABEL maintainer="Junhyeok Seo <jun2342@chungbuk.ac.kr>"

# Set noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=noetic

# Install dependencies
RUN apt-get update && apt-get install -y \
    locales \
    curl \
    gnupg2 \
    lsb-release \
    ca-certificates \
    software-properties-common \
    build-essential \
    nano \
    sudo \
    wget \
    git \
    gosu \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable Ubuntu universe for ROS helper packages
RUN add-apt-repository universe

# Setup sources and keys for ROS1
RUN curl -fsSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc \
    | gpg --dearmor -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" \
    > /etc/apt/sources.list.d/ros1-latest.list

# Install ROS1 Noetic and tools
RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-desktop-full \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    build-essential \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Initialize rosdep. Update is intentionally skipped here because it can fail
# nondeterministically during image build and is not required for a usable base image.
RUN rosdep init || true

# Create user as uid 1001
RUN useradd --shell /bin/bash -u 1001 -c "" -m user && usermod -a -G dialout user

# Add user to sudoers
RUN echo user ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/user \
    && chmod 0440 /etc/sudoers.d/user

# Make ros command available by default for user
SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc \
    && echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /home/user/.bashrc

# Entrypoint
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Set working directory
WORKDIR /home/user

CMD ["/bin/bash"]
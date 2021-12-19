# build the repo
FROM ros:noetic-perception AS builder
SHELL ["/bin/bash", "-c"]

# install build dependencies
RUN sudo apt update && sudo apt install -y \
    ros-noetic-rviz \
    ros-noetic-ackermann-msgs \
    ros-noetic-derived-object-msgs \
    ros-noetic-rqt

# copy over our code, build it in release,
# and install it to a known location
COPY catkin_ws catkin_ws
WORKDIR /catkin_ws/ 
RUN . /opt/ros/noetic/setup.sh && \
    catkin_make install \
    -DCMAKE_INSTALL_PREFIX=/opt/lane-keep/core/ \
    -DCMAKE_BUILD_TYPE=Release 
    
# run the ros system
FROM ros:noetic

# copy over the build artifacts
COPY --from=builder /opt/lane-keep/core /opt/lane-keep/core

# by default, just run the ros system
SHELL ["/bin/bash", "-c"]

# default command to run the autonomy
CMD . /opt/ros/noetic/setup.sh && \
    . /opt/lane-keep/core/setup.sh && \
    roslaunch ego_controller main.launch
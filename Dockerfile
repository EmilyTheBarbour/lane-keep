# build the repo
FROM ros:noetic AS builder
SHELL ["/bin/bash", "-c"]

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
CMD . /opt/ros/noetic/setup.sh && \
    . /opt/lane-keep/core/setup.sh && \
    roslaunch ego_controller main.launch
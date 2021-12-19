cmake_minimum_required(VERSION 3.0.2)
project(ego_controller)

# get catkin and components
find_package(catkin REQUIRED COMPONENTS
    roscpp rospy std_msgs genmsg
)

# declare catkin package
catkin_package()

# build talker
add_executable(talker src/talker.cpp)
target_include_directories(talker PUBLIC ${catkin_INCLUDE_DIRS})
target_link_libraries(talker ${catkin_LIBRARIES})

# build listener
add_executable(listener src/listener.cpp)
target_include_directories(listener PUBLIC ${catkin_INCLUDE_DIRS})
target_link_libraries(listener ${catkin_LIBRARIES})

# install the objects
install(TARGETS talker listener
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

# install the launch files
install(DIRECTORY launch/
    DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch
)














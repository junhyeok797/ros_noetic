#!/bin/bash

set -e

if [ -n "${LOCAL_USER_ID}" ]; then
	current_user_id="$(id -u user)"
	if [ "${current_user_id}" != "${LOCAL_USER_ID}" ]; then
		echo "Starting with UID: ${LOCAL_USER_ID}"
		usermod -u "${LOCAL_USER_ID}" user
		chown -R user:user /home/user
	fi
	source /opt/ros/${ROS_DISTRO}/setup.bash
	exec gosu user "$@"
else
	source /opt/ros/${ROS_DISTRO}/setup.bash
	exec "$@"
fi
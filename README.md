# ros_noetic

ROS Noetic 개발용 Docker 환경입니다. 베이스 이미지는 `osrf/ros:noetic-desktop-full-focal`이고, 컨테이너 안에 `user` 계정을 만들어 `sudo`를 사용할 수 있게 구성했습니다.

## Build

GPU 이미지:

```bash
docker build -f docker/Dockerfile -t ros_noetic:noetic .
```

## Run

GPU가 필요한 경우:

```bash
./run_docker.sh
```

GPU가 필요 없는 경우:

```bash
./run_docker_no_gpu.sh
```

두 스크립트 모두 컨테이너 시작 시 `LOCAL_USER_ID`를 넘겨서 호스트 UID와 맞춥니다. 이때 entrypoint가 `/home/user` 소유권을 정리하고 `user`로 실행합니다.

## Container Access

컨테이너에 들어갈 때는 `docker exec -u user`를 쓰면 root가 아니라 `user`로 접속할 수 있습니다.

```bash
docker exec -u user -it <container_name> bash
```

`docker exec`는 기본적으로 별도 user를 지정하지 않으면 root로 실행되는 경우가 많기 때문에, 쉘 접속을 user로 맞추고 싶으면 `-u user`를 명시하는 편이 안전합니다.

## Workspace

컨테이너 내부에는 기본적으로 `/home/user/catkin_ws`가 생성됩니다.

```bash
cd ~/catkin_ws
catkin_make
```

## Notes

- `sudo`는 컨테이너 내부의 `user` 계정에서 사용할 수 있습니다.
- `docker run`에서는 entrypoint가 UID를 맞추기 때문에 `-u user`를 붙이지 않습니다.
- `docker exec`에서만 `-u user`를 붙여 일반 사용자 셸로 들어가는 것을 권장합니다.
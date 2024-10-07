image_name="hlds"
docker_build(image_name, ".")

services={'hlds': {'image': 'hlds'}}
docker_compose(encode_yaml({'services': services}))
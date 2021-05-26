[
  {
    "essential": true,
    "memory": 256,
    "name": "nginx-container",
    "cpu": 256,
    "image": "registry.hub.docker.com/library/nginx:latest",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 0
      }
    ]
  }
]
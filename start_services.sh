## Up Services
```
#!/bin/bash
PROJECT_ROOT="/home/marcelo/projects/github/end2end-spark-lakehouse-stack"

run_docker_compose() {
    local service_path="$1"
    echo "Running docker-compose in $service_path"
    cd "$service_path" || { echo "Failed to change directory to $service_path"; exit 1; }
    docker-compose up -d
}

run_docker_compose "$PROJECT_ROOT/applications/postgres"
run_docker_compose "$PROJECT_ROOT/applications/minio"
run_docker_compose "$PROJECT_ROOT/applications/spark"
run_docker_compose "$PROJECT_ROOT/applications/trino"
run_docker_compose "$PROJECT_ROOT/applications/airflow"
run_docker_compose "$PROJECT_ROOT/applications/superset"
run_docker_compose "$PROJECT_ROOT/applications/open_metadata"
run_docker_compose "$PROJECT_ROOT/applications/portaneir"
run_docker_compose "$PROJECT_ROOT/applications/cloudbeaver"

echo "All services started!"
```
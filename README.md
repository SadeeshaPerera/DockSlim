# DockSlim

DockSlim is a tool for comparing Docker images across multiple optimization metrics, helping you choose the best image for your needs. It automates the build, analysis, and visualization of Docker images.

## Features

- **Compare different Docker images in terms of:**
  - **Image size**: See how much space each image consumes.
  - **Build time**: Measure how long it takes to build each image.
  - **Startup time**: Track how quickly containers start from each image.
  - **Layer count**: Analyze the number of layers in each image for optimization.
  - **Security vulnerabilities**: Scan images for known vulnerabilities using tools like Trivy or Grype.
- **Automated Metrics Collection**: Scripts build images, collect metrics, and push them to Prometheus Pushgateway.
- **Grafana Dashboards**: Visualize all metrics in real time with pre-built Grafana dashboards.

## How It Works

1. **Build and Analyze**: The provided script builds each Docker image, times the build, checks image size, layer count, and scans for vulnerabilities.
2. **Metrics Export**: All metrics are pushed to Prometheus Pushgateway.
3. **Visualization**: Grafana dashboards display and compare all collected metrics for easy analysis.

## Quick Start

1. Clone this repository.
2. Run `docker-compose up -d` to start Prometheus, Pushgateway, and Grafana.
3. Run the build script: `./build_and_push_metrics.sh` (install `bc` if missing).
4. Open Grafana at [http://localhost:3000](http://localhost:3000) (default user: admin/admin).
5. Explore the "Docker Image Build Metrics" dashboard.

## Requirements
- Docker & Docker Compose
- Prometheus, Pushgateway, Grafana (auto-provisioned)
- `bc` utility (for build script)

## Customization
- Add or modify Dockerfiles to compare different images.
- Extend the script to collect more metrics as needed.

---

Contributions welcome!

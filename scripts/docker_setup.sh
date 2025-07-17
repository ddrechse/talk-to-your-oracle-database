#!/bin/bash

# =================================================================
# Docker Oracle Setup Script
# Sets up Oracle Database Free 23ai for AI-powered development demo
# =================================================================

set -e  # Exit on any error

# Configuration
CONTAINER_NAME="oracle-demo"
ORACLE_PASSWORD="Welcome12345"
APP_USER="hr"
APP_USER_PASSWORD="Welcome12345"
ORACLE_PORT="1521"
ORACLE_IMAGE="gvenzl/oracle-free:23.7-slim-faststart"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is installed and running
check_docker() {
    print_status "Checking Docker installation..."
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker and try again."
        exit 1
    fi
    
    if ! docker info &> /dev/null; then
        print_error "Docker daemon is not running. Please start Docker and try again."
        exit 1
    fi
    
    print_status "Docker is running ✓"
}

# Check if container already exists
check_existing_container() {
    if docker ps -a --format "table {{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
        print_warning "Container '${CONTAINER_NAME}' already exists."
        read -p "Do you want to remove it and create a new one? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_status "Removing existing container..."
            docker rm -f ${CONTAINER_NAME}
        else
            print_status "Using existing container..."
            return 0
        fi
    fi
}

# Check if port is available
check_port() {
    print_status "Checking if port ${ORACLE_PORT} is available..."
    if lsof -i :${ORACLE_PORT} &> /dev/null; then
        print_error "Port ${ORACLE_PORT} is already in use."
        print_status "You can either:"
        print_status "1. Stop the process using port ${ORACLE_PORT}"
        print_status "2. Use a different port (edit ORACLE_PORT in this script)"
        exit 1
    fi
    print_status "Port ${ORACLE_PORT} is available ✓"
}

# Start Oracle container
start_container() {
    print_status "Starting Oracle Database Free 23ai container..."
    print_status "This may take a few minutes on first run..."
    
    docker run --name ${CONTAINER_NAME} -d \
        -p ${ORACLE_PORT}:1521 \
        -e ORACLE_PASSWORD=${ORACLE_PASSWORD} \
        -e APP_USER=${APP_USER} \
        -e APP_USER_PASSWORD=${APP_USER_PASSWORD} \
        ${ORACLE_IMAGE}
    
    if [ $? -eq 0 ]; then
        print_status "Container started successfully ✓"
    else
        print_error "Failed to start container"
        exit 1
    fi
}

# Wait for database to be ready
wait_for_database() {
    print_status "Waiting for database to be ready..."
    print_status "This can take 2-5 minutes depending on your system..."
    
    local max_attempts=60
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        if docker logs ${CONTAINER_NAME} 2>&1 | grep -q "DATABASE IS READY TO USE!"; then
            print_status "Database is ready! ✓"
            return 0
        fi
        
        printf "."
        sleep 5
        ((attempt++))
    done
    
    print_error "Database failed to start within expected time"
    print_status "Check container logs: docker logs ${CONTAINER_NAME}"
    exit 1
}

# Test database connection
test_connection() {
    print_status "Testing database connection..."
    
    # Test if we can connect
    docker exec ${CONTAINER_NAME} sqlplus -S ${APP_USER}/${APP_USER_PASSWORD}@FREEPDB1 <<EOF
SELECT 'Connection successful!' as status FROM dual;
EXIT;
EOF
    
    if [ $? -eq 0 ]; then
        print_status "Database connection test passed ✓"
    else
        print_error "Database connection test failed"
        exit 1
    fi
}

# Create HR schema and load sample data
setup_schema() {
    print_status "Setting up HR schema and sample data..."
    
    # Check if schema files exist
    if [ ! -f "sql/setup/create_hr_schema.sql" ]; then
        print_error "Schema file not found: sql/setup/create_hr_schema.sql"
        print_status "Please run this script from the project root directory"
        exit 1
    fi
    
    # Copy SQL files to container
    docker cp sql/setup/create_hr_schema.sql ${CONTAINER_NAME}:/tmp/
    docker cp sql/setup/load_sample_data.sql ${CONTAINER_NAME}:/tmp/
    
    # Execute schema creation
    docker exec ${CONTAINER_NAME} sqlplus ${APP_USER}/${APP_USER_PASSWORD}@FREEPDB1 <<EOF
@/tmp/create_hr_schema.sql
@/tmp/load_sample_data.sql
EXIT;
EOF
    
    if [ $? -eq 0 ]; then
        print_status "HR schema created and sample data loaded ✓"
    else
        print_error "Failed to create schema or load data"
        exit 1
    fi
}

# Display connection information
display_info() {
    print_status "==================================="
    print_status "Oracle Database Setup Complete!"
    print_status "==================================="
    echo
    print_status "Container: ${CONTAINER_NAME}"
    print_status "Database: Oracle Free 23ai"
    print_status "Port: ${ORACLE_PORT}"
    print_status "Service: FREEPDB1"
    print_status "User: ${APP_USER}"
    print_status "Password: ${APP_USER_PASSWORD}"
    echo
    print_status "Connection string: ${APP_USER}/${APP_USER_PASSWORD}@localhost:${ORACLE_PORT}/FREEPDB1"
    echo
    print_status "Useful commands:"
    print_status "  Start container: docker start ${CONTAINER_NAME}"
    print_status "  Stop container: docker stop ${CONTAINER_NAME}"
    print_status "  View logs: docker logs ${CONTAINER_NAME}"
    print_status "  Connect to DB: docker exec -it ${CONTAINER_NAME} sqlplus ${APP_USER}/${APP_USER_PASSWORD}@FREEPDB1"
    echo
    print_status "Next steps:"
    print_status "1. Test connection: sql ${APP_USER}/${APP_USER_PASSWORD}@localhost:${ORACLE_PORT}/FREEPDB1"
    print_status "2. Create saved connection: conn -save hr_demo -savepwd"
    print_status "3. Configure Cline MCP settings"
    print_status "4. Start MCP server: sql -mcp"
    echo
}

# Main execution
main() {
    echo "=========================================="
    echo "Oracle Database Setup for AI Development"
    echo "=========================================="
    echo
    
    check_docker
    check_existing_container
    check_port
    start_container
    wait_for_database
    test_connection
    setup_schema
    display_info
    
    print_status "Setup completed successfully! 🎉"
}

# Run main function
main "$@"
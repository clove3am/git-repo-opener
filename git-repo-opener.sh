#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to check if Git is installed
check_git_installed() {
    if ! command -v git >/dev/null 2>&1; then
        error_message "Git is not installed. Please install Git before running this script."
    fi
}

# Function to display help message
show_help() {
    echo -e "${GREEN}Usage: ${0} [-h|--help] [-d|--directory <path>] [-p|--print]${NC}"
    echo
    echo "This script opens the remote Git repository URL in your default web browser."
    echo
    echo -e "${YELLOW}Options:${NC}"
    echo "  -h, --help                Show this help message and exit"
    echo "  -d, --directory <path>    Specify the Git repository directory (default: current directory)"
    echo "  -p, --print               Only print the URL, don't open in browser"
}

# Function to display error messages
error_message() {
    echo -e "${RED}Error: ${1}${NC}" >&2
    exit 1
}

# Function to get the remote URL
get_remote_url() {
    git -C "${1}" config --get remote.origin.url 2>/dev/null
}

# Function to convert SSH URL to HTTPS and clean up URL
clean_url() {
    local url="${1}"
    # Handle SSH URLs
    if [[ ${url} =~ ^git@([^:]+):(.+)\.git$ ]]; then
        local domain="${BASH_REMATCH[1]}"
        local path="${BASH_REMATCH[2]}"
        echo "https://${domain}/${path}"
    elif [[ ${url} =~ ^git:// ]]; then
        echo "${url}" | sed 's|^git:|https:|; s|\.git$||'
    # Handle HTTPS URLs
    elif [[ ${url} =~ ^https?:// ]]; then
        echo "${url}" | sed 's|.git$||'
    else
        echo "${url}"
    fi
}

# Function to find the root of the Git repository
find_git_root() {
    git -C "${1}" rev-parse --show-toplevel 2>/dev/null
}

# Parse command line arguments
REPO_DIR="."
PRINT_ONLY=false

# Check if Git is installed before processing any arguments
check_git_installed

while [[ $# -gt 0 ]]; do
    case ${1} in
    -h | --help)
        show_help
        exit 0
        ;;
    -d | --directory)
        if [ -n "${2}" ] && [ ${2:0:1} != "-" ]; then
            REPO_DIR="${2}"
            shift 2
        else
            error_message "Directory path is missing after -d|--directory option"
        fi
        ;;
    -p | --print)
        PRINT_ONLY=true
        shift
        ;;
    *)
        error_message "Unknown option: ${1}\nUse -h or --help for usage information"
        ;;
    esac
done

# Validate the specified directory
[ -d "${REPO_DIR}" ] || error_message "The specified directory does not exist: ${REPO_DIR}"

# Main script
GIT_ROOT=$(find_git_root "${REPO_DIR}")

[ -n "${GIT_ROOT}" ] || error_message "Not a Git repository: ${REPO_DIR}"

REMOTE_URL=$(get_remote_url "${GIT_ROOT}")

[ -n "${REMOTE_URL}" ] || error_message "No remote URL found in the Git repository: ${GIT_ROOT}"

# Clean up the URL
REMOTE_URL=$(clean_url "${REMOTE_URL}")

if [ "${PRINT_ONLY}" = true ]; then
    echo -e "${GREEN}${REMOTE_URL}${NC}"
else
    # Open the URL in the default browser
    if command -v xdg-open >/dev/null; then
        xdg-open "${REMOTE_URL}"
        echo -e "${YELLOW}Opening URL: ${GREEN}${REMOTE_URL}${NC}"
    else
        error_message "Unable to open the URL. Please open it manually:\n${GREEN}${REMOTE_URL}${NC}"
    fi
fi

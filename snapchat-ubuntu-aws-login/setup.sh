#!/bin/bash

# Snapchat Login Automation - Ubuntu AWS Setup Script
# This script automates the installation and setup process

set -e

echo "========================================"
echo "Snapchat Login Automation Setup"
echo "========================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running on Ubuntu/Debian
if ! command -v apt-get &> /dev/null; then
    echo -e "${RED}Error: This script requires apt-get (Ubuntu/Debian)${NC}"
    exit 1
fi

echo -e "${YELLOW}Step 1: Updating system packages...${NC}"
sudo apt-get update

echo ""
echo -e "${YELLOW}Step 2: Installing Python 3 and pip...${NC}"
sudo apt-get install -y python3 python3-pip python3-venv wget curl unzip

echo ""
echo -e "${YELLOW}Step 3: Checking for Google Chrome...${NC}"
if ! command -v google-chrome &> /dev/null; then
    echo "Chrome not found. Installing..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
    echo -e "${GREEN}Chrome installed successfully${NC}"
else
    echo -e "${GREEN}Chrome already installed${NC}"
    google-chrome --version
fi

echo ""
echo -e "${YELLOW}Step 4: Checking for ChromeDriver...${NC}"
if ! command -v chromedriver &> /dev/null; then
    echo "ChromeDriver not found. Installing..."

    # Get Chrome version
    CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | cut -d. -f1)

    # Get matching ChromeDriver version
    wget https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_VERSION} -O /tmp/version
    CHROMEDRIVER_VERSION=$(cat /tmp/version)

    # Download and install
    wget https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip
    unzip chromedriver_linux64.zip
    sudo mv chromedriver /usr/local/bin/
    sudo chmod +x /usr/local/bin/chromedriver

    # Clean up
    rm chromedriver_linux64.zip /tmp/version

    echo -e "${GREEN}ChromeDriver installed successfully${NC}"
else
    echo -e "${GREEN}ChromeDriver already installed${NC}"
    chromedriver --version
fi

echo ""
echo -e "${YELLOW}Step 5: Setting up Python virtual environment...${NC}"
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo -e "${GREEN}Virtual environment created${NC}"
else
    echo -e "${GREEN}Virtual environment already exists${NC}"
fi

echo ""
echo -e "${YELLOW}Step 6: Installing Python dependencies...${NC}"
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
echo -e "${GREEN}Python dependencies installed${NC}"

echo ""
echo -e "${YELLOW}Step 7: Setting up environment configuration...${NC}"
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo -e "${YELLOW}Created .env file. Please edit it with your credentials:${NC}"
    echo "  nano .env"
else
    echo -e "${GREEN}.env file already exists${NC}"
fi

echo ""
echo "========================================"
echo -e "${GREEN}Setup completed successfully!${NC}"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. Edit .env file with your Snapchat credentials:"
echo "   nano .env"
echo ""
echo "2. Activate the virtual environment:"
echo "   source venv/bin/activate"
echo ""
echo "3. Run the script:"
echo "   python3 src/snapchat_login.py"
echo ""
echo "For more information, see README.md"
echo ""

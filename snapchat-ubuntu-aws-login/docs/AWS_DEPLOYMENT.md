# AWS EC2 Deployment Guide

Complete guide for deploying the Snapchat Login Automation on AWS EC2.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [EC2 Instance Setup](#ec2-instance-setup)
3. [Installation](#installation)
4. [Running the Application](#running-the-application)
5. [Advanced Configuration](#advanced-configuration)
6. [Security Considerations](#security-considerations)
7. [Troubleshooting](#troubleshooting)

## Prerequisites

- AWS Account
- AWS CLI installed (optional but recommended)
- SSH key pair for EC2 access
- Basic knowledge of AWS EC2 and Linux

## EC2 Instance Setup

### 1. Launch EC2 Instance

#### Using AWS Console:

1. Log into AWS Console
2. Navigate to EC2 Dashboard
3. Click "Launch Instance"
4. Configure instance:
   - **Name**: snapchat-login-server
   - **AMI**: Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
   - **Instance Type**: t2.micro (Free tier eligible) or t2.small (recommended)
   - **Key Pair**: Select or create a new key pair
   - **Network Settings**:
     - Auto-assign public IP: Enable
     - Security Group: Create new or use existing
   - **Storage**: 8-16 GB (default is fine)

5. Configure Security Group:
   - **SSH (22)**: Your IP only (for secure access)
   - **Optional - HTTP (80)**: If you plan to add web interface
   - **Optional - HTTPS (443)**: If you plan to add web interface

6. Click "Launch Instance"

#### Using AWS CLI:

```bash
# Create security group
aws ec2 create-security-group \
  --group-name snapchat-login-sg \
  --description "Security group for Snapchat login automation"

# Allow SSH from your IP
aws ec2 authorize-security-group-ingress \
  --group-name snapchat-login-sg \
  --protocol tcp \
  --port 22 \
  --cidr YOUR_IP/32

# Launch instance
aws ec2 run-instances \
  --image-id ami-0c7217cdde317cfec \
  --count 1 \
  --instance-type t2.micro \
  --key-name YOUR_KEY_NAME \
  --security-groups snapchat-login-sg \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=snapchat-login-server}]'
```

### 2. Connect to Instance

```bash
# Set correct permissions for key
chmod 400 your-key.pem

# Connect via SSH
ssh -i your-key.pem ubuntu@YOUR_INSTANCE_PUBLIC_IP
```

## Installation

Once connected to your EC2 instance:

### 1. Update System

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

### 2. Install Python and Dependencies

```bash
# Install Python 3 and pip
sudo apt-get install -y python3 python3-pip python3-venv

# Install additional dependencies
sudo apt-get install -y wget curl unzip
```

### 3. Install Chrome

```bash
# Download and install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

# Verify installation
google-chrome --version

# Clean up
rm google-chrome-stable_current_amd64.deb
```

### 4. Install ChromeDriver

```bash
# Install ChromeDriver (match version with Chrome)
CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | cut -d. -f1)
wget https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_VERSION} -O /tmp/version
CHROMEDRIVER_VERSION=$(cat /tmp/version)
wget https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/local/bin/
sudo chmod +x /usr/local/bin/chromedriver

# Verify installation
chromedriver --version

# Clean up
rm chromedriver_linux64.zip /tmp/version
```

### 5. Clone/Upload Project

#### Option A: Clone from Git

```bash
# Install git if not already installed
sudo apt-get install -y git

# Clone your repository
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO/snapchat-ubuntu-aws-login
```

#### Option B: Upload via SCP

```bash
# From your local machine
scp -i your-key.pem -r snapchat-ubuntu-aws-login ubuntu@YOUR_INSTANCE_PUBLIC_IP:~/
```

### 6. Set Up Python Environment

```bash
# Navigate to project directory
cd ~/snapchat-ubuntu-aws-login

# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate

# Install Python dependencies
pip install -r requirements.txt
```

### 7. Configure Environment

```bash
# Copy environment template
cp .env.example .env

# Edit with your credentials
nano .env
```

Add your credentials:
```
SNAPCHAT_USERNAME=your_username
SNAPCHAT_PASSWORD=your_password
```

Save and exit (Ctrl+X, then Y, then Enter)

## Running the Application

### Basic Execution

```bash
# Activate virtual environment (if not already activated)
source venv/bin/activate

# Run the script
python3 src/snapchat_login.py
```

### Running in Background

```bash
# Using nohup
nohup python3 src/snapchat_login.py &

# View logs
tail -f snapchat_login.log
```

### Using Screen (Recommended for Long Sessions)

```bash
# Install screen
sudo apt-get install -y screen

# Start a new screen session
screen -S snapchat

# Run your script
python3 src/snapchat_login.py --keep-alive 3600

# Detach from screen: Press Ctrl+A, then D

# Reattach to screen
screen -r snapchat

# List all screens
screen -ls
```

### Using Systemd Service (For Automatic Startup)

Create a systemd service file:

```bash
sudo nano /etc/systemd/system/snapchat-login.service
```

Add the following:

```ini
[Unit]
Description=Snapchat Login Automation
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/snapchat-ubuntu-aws-login
Environment="PATH=/home/ubuntu/snapchat-ubuntu-aws-login/venv/bin"
ExecStart=/home/ubuntu/snapchat-ubuntu-aws-login/venv/bin/python3 /home/ubuntu/snapchat-ubuntu-aws-login/src/snapchat_login.py
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Enable and start the service:

```bash
# Reload systemd
sudo systemctl daemon-reload

# Enable service to start on boot
sudo systemctl enable snapchat-login

# Start the service
sudo systemctl start snapchat-login

# Check status
sudo systemctl status snapchat-login

# View logs
sudo journalctl -u snapchat-login -f
```

## Advanced Configuration

### Using AWS Secrets Manager

For enhanced security, store credentials in AWS Secrets Manager:

```bash
# Install boto3
pip install boto3

# Store secret
aws secretsmanager create-secret \
  --name snapchat-credentials \
  --secret-string '{"username":"your_username","password":"your_password"}'
```

Modify your script to retrieve secrets:

```python
import boto3
import json

def get_credentials():
    client = boto3.client('secretsmanager', region_name='us-east-1')
    response = client.get_secret_value(SecretId='snapchat-credentials')
    secret = json.loads(response['SecretString'])
    return secret['username'], secret['password']
```

### IAM Role Setup

1. Create IAM role with SecretsManager read permissions
2. Attach role to EC2 instance
3. Remove credentials from .env file

### Scheduled Execution with Cron

```bash
# Edit crontab
crontab -e

# Add entry (run daily at 9 AM)
0 9 * * * /home/ubuntu/snapchat-ubuntu-aws-login/venv/bin/python3 /home/ubuntu/snapchat-ubuntu-aws-login/src/snapchat_login.py >> /home/ubuntu/cron.log 2>&1
```

## Security Considerations

### 1. Secure Your .env File

```bash
# Restrict permissions
chmod 600 .env

# Ensure only you can read it
ls -la .env
```

### 2. Use SSH Key Authentication Only

```bash
# Disable password authentication
sudo nano /etc/ssh/sshd_config

# Set: PasswordAuthentication no
# Restart SSH
sudo systemctl restart sshd
```

### 3. Security Group Best Practices

- Only allow SSH from your IP
- Use security group rules to restrict access
- Consider using AWS Session Manager instead of SSH

### 4. Regular Updates

```bash
# Set up automatic security updates
sudo apt-get install -y unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades
```

### 5. Monitoring and Alerts

- Set up CloudWatch alarms
- Monitor CPU and memory usage
- Track application logs

## Troubleshooting

### Chrome Not Found

```bash
# Verify Chrome installation
which google-chrome
google-chrome --version

# Reinstall if needed
sudo apt-get install --reinstall google-chrome-stable
```

### ChromeDriver Issues

```bash
# Check ChromeDriver version matches Chrome
chromedriver --version
google-chrome --version

# Download matching version if needed
```

### Memory Issues on t2.micro

```bash
# Add swap space
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Make permanent
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

### Display Issues in Headless Mode

```bash
# Install virtual display
sudo apt-get install -y xvfb

# Run with virtual display
xvfb-run python3 src/snapchat_login.py
```

### Check Logs

```bash
# Application logs
tail -f snapchat_login.log

# System logs
sudo journalctl -xe

# Systemd service logs
sudo journalctl -u snapchat-login -f
```

## Cost Optimization

### 1. Use Spot Instances

For non-critical workloads, use spot instances to save up to 90%.

### 2. Schedule Instance Start/Stop

```bash
# Using AWS Instance Scheduler
# Or create Lambda functions to start/stop instances
```

### 3. Right-Sizing

- Start with t2.micro
- Monitor usage with CloudWatch
- Upgrade only if needed

## Backup and Recovery

```bash
# Create AMI backup
aws ec2 create-image \
  --instance-id YOUR_INSTANCE_ID \
  --name "snapchat-login-backup-$(date +%Y%m%d)" \
  --description "Backup of Snapchat login automation"
```

## Next Steps

- Set up monitoring with CloudWatch
- Configure automated backups
- Implement error notifications (SNS, email)
- Add web interface for remote management
- Implement session persistence

## Support

For issues specific to AWS deployment, refer to:
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [AWS Support](https://aws.amazon.com/support/)

For application issues, check the main [README.md](../README.md).

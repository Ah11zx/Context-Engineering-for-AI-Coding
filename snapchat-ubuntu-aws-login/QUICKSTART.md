# Quick Start Guide

Get up and running with Snapchat Login Automation in 5 minutes!

## For Ubuntu/AWS Users

### One-Command Setup

```bash
# Clone the repository (if not already done)
git clone <repository-url>
cd snapchat-ubuntu-aws-login

# Run the automated setup script
./setup.sh
```

The setup script will:
- Install all system dependencies
- Install Chrome and ChromeDriver
- Set up Python virtual environment
- Install Python packages
- Create .env configuration file

### Configure Credentials

```bash
# Edit the .env file
nano .env
```

Add your credentials:
```
SNAPCHAT_USERNAME=your_username_or_email
SNAPCHAT_PASSWORD=your_password
```

Save and exit (Ctrl+X, Y, Enter)

### Run the Application

```bash
# Activate virtual environment
source venv/bin/activate

# Run the script
python3 src/snapchat_login.py
```

## Manual Setup (Alternative)

If you prefer manual installation or the script doesn't work:

### 1. Install Chrome

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
```

### 2. Install ChromeDriver

```bash
wget https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/local/bin/
sudo chmod +x /usr/local/bin/chromedriver
```

### 3. Setup Python Environment

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 4. Configure and Run

```bash
cp .env.example .env
nano .env  # Add your credentials
python3 src/snapchat_login.py
```

## Common Issues

### Chrome/ChromeDriver Mismatch
```bash
google-chrome --version
chromedriver --version
# Versions should match
```

### Headless Mode Fails
```bash
# Try with visible browser
python3 src/snapchat_login.py --visible
```

### Permission Denied
```bash
chmod +x setup.sh
chmod 600 .env
```

## Next Steps

- Read the full [README.md](README.md) for detailed documentation
- Check [AWS_DEPLOYMENT.md](docs/AWS_DEPLOYMENT.md) for AWS-specific setup
- Review logs in `snapchat_login.log` for troubleshooting

## Quick Commands Reference

```bash
# Run with visible browser
python3 src/snapchat_login.py --visible

# Keep session alive for 5 minutes
python3 src/snapchat_login.py --keep-alive 300

# View logs
tail -f snapchat_login.log

# Deactivate virtual environment
deactivate
```

## Need Help?

1. Check the logs: `cat snapchat_login.log`
2. Look for screenshots: `ls -lt *.png`
3. Read the full documentation in README.md
4. Review troubleshooting section in AWS_DEPLOYMENT.md

---

**Security Reminder**: Never commit your `.env` file to version control!

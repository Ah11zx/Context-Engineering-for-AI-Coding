# Snapchat Login Automation for Ubuntu AWS

A Python-based automation tool to log into Snapchat from Ubuntu instances, specifically designed for AWS EC2 environments.

## Features

- Automated Snapchat web login using Selenium WebDriver
- Headless browser support for server environments
- Secure credential management via environment variables
- Comprehensive logging and error handling
- Screenshot capture for debugging
- Optimized for Ubuntu/AWS EC2 instances

## Prerequisites

- Ubuntu 18.04+ (or compatible Linux distribution)
- Python 3.8+
- Chrome/Chromium browser
- ChromeDriver

## Installation

### 1. System Dependencies

First, install Chrome and ChromeDriver on your Ubuntu instance:

```bash
# Update package list
sudo apt-get update

# Install Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

# Verify Chrome installation
google-chrome --version

# Install ChromeDriver
wget https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/local/bin/
sudo chmod +x /usr/local/bin/chromedriver

# Verify ChromeDriver installation
chromedriver --version
```

Alternative: Use webdriver-manager (included in requirements.txt) to automatically manage ChromeDriver.

### 2. Python Dependencies

```bash
# Navigate to project directory
cd snapchat-ubuntu-aws-login

# Create virtual environment (recommended)
python3 -m venv venv
source venv/bin/activate

# Install Python packages
pip install -r requirements.txt
```

### 3. Configuration

```bash
# Copy environment template
cp .env.example .env

# Edit .env with your credentials
nano .env
```

Add your Snapchat credentials:
```
SNAPCHAT_USERNAME=your_username_or_email
SNAPCHAT_PASSWORD=your_password
```

**IMPORTANT**: Never commit your `.env` file to version control!

## Usage

### Basic Usage

```bash
# Using environment variables from .env
python3 src/snapchat_login.py

# Or provide credentials via command line
python3 src/snapchat_login.py --username your_username --password your_password
```

### Advanced Options

```bash
# Run with visible browser (for debugging)
python3 src/snapchat_login.py --visible

# Keep session alive for 300 seconds (5 minutes)
python3 src/snapchat_login.py --keep-alive 300

# Combine options
python3 src/snapchat_login.py --visible --keep-alive 600
```

### Command Line Arguments

- `--username`: Snapchat username or email (overrides .env)
- `--password`: Snapchat password (overrides .env)
- `--headless`: Run in headless mode (default: True)
- `--visible`: Run with visible browser window
- `--keep-alive`: Seconds to keep session alive after login (default: 60)

## Project Structure

```
snapchat-ubuntu-aws-login/
├── src/
│   └── snapchat_login.py    # Main automation script
├── config/                   # Configuration files (optional)
├── docs/                     # Additional documentation
│   └── AWS_DEPLOYMENT.md    # AWS-specific deployment guide
├── .env.example             # Environment template
├── .gitignore               # Git ignore rules
├── requirements.txt         # Python dependencies
└── README.md               # This file
```

## Security Best Practices

1. **Never hardcode credentials** - Use environment variables
2. **Use .gitignore** - Ensure .env is never committed
3. **AWS Secrets Manager** - Consider using AWS Secrets Manager for production
4. **IAM Roles** - Use IAM roles for EC2 instances instead of access keys
5. **Regular Updates** - Keep dependencies updated for security patches

## Troubleshooting

### Chrome/ChromeDriver Version Mismatch

```bash
# Check Chrome version
google-chrome --version

# Download matching ChromeDriver from:
# https://chromedriver.chromium.org/downloads
```

### Headless Mode Issues

If headless mode fails, try running with `--visible` flag to see what's happening:

```bash
python3 src/snapchat_login.py --visible
```

### Two-Factor Authentication (2FA)

If your account has 2FA enabled, you'll need to:
1. Disable 2FA temporarily, or
2. Modify the script to handle 2FA prompts manually

### Login Failures

- Check credentials are correct in .env
- Verify Chrome and ChromeDriver are properly installed
- Check logs in `snapchat_login.log`
- Review screenshots generated in the project directory

## Logs and Debugging

- Logs are saved to `snapchat_login.log`
- Screenshots are automatically captured on errors
- Use `--visible` flag to watch the browser in action

## Limitations

- Snapchat may detect automation and require captcha
- 2FA requires manual intervention
- Session management is temporary (closes after keep-alive period)
- Not suitable for continuous/production use without additional anti-detection measures

## Important Notes

- This tool is for personal use to access YOUR OWN account
- Respect Snapchat's Terms of Service
- Use responsibly and ethically
- Not intended for scraping or unauthorized access
- May require periodic updates as Snapchat's interface changes

## AWS Deployment

See [AWS_DEPLOYMENT.md](docs/AWS_DEPLOYMENT.md) for detailed instructions on deploying to AWS EC2.

## License

This project is for educational and personal use only.

## Contributing

Feel free to submit issues or pull requests for improvements.

## Disclaimer

This tool is provided as-is for personal use. The authors are not responsible for any misuse or violation of Snapchat's Terms of Service. Use at your own risk.

#!/usr/bin/env python3
"""
Snapchat Login Automation for Ubuntu AWS
This script automates the login process to Snapchat using Selenium WebDriver.
Designed to run on Ubuntu instances, including AWS EC2.
"""

import os
import sys
import time
import logging
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import TimeoutException, NoSuchElementException
from dotenv import load_dotenv

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('snapchat_login.log'),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)


class SnapchatLoginBot:
    """
    A bot to automate Snapchat login process using Selenium WebDriver.
    """

    def __init__(self, username=None, password=None, headless=True):
        """
        Initialize the Snapchat login bot.

        Args:
            username (str): Snapchat username or email
            password (str): Snapchat password
            headless (bool): Run browser in headless mode (default: True)
        """
        load_dotenv()

        self.username = username or os.getenv('SNAPCHAT_USERNAME')
        self.password = password or os.getenv('SNAPCHAT_PASSWORD')
        self.headless = headless
        self.driver = None

        if not self.username or not self.password:
            raise ValueError("Username and password must be provided via arguments or environment variables")

    def setup_driver(self):
        """
        Set up Chrome WebDriver with appropriate options for Ubuntu/AWS.
        """
        logger.info("Setting up Chrome WebDriver...")

        chrome_options = Options()

        if self.headless:
            chrome_options.add_argument('--headless')
            chrome_options.add_argument('--disable-gpu')

        # Essential options for running on Ubuntu/AWS
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-dev-shm-usage')
        chrome_options.add_argument('--disable-blink-features=AutomationControlled')
        chrome_options.add_argument('--window-size=1920,1080')
        chrome_options.add_argument('--user-agent=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36')

        # Additional options for better compatibility
        chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
        chrome_options.add_experimental_option('useAutomationExtension', False)

        try:
            self.driver = webdriver.Chrome(options=chrome_options)
            self.driver.execute_cdp_cmd('Network.setUserAgentOverride', {
                "userAgent": 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
            })
            logger.info("Chrome WebDriver setup successful")
        except Exception as e:
            logger.error(f"Failed to setup Chrome WebDriver: {e}")
            raise

    def navigate_to_snapchat(self):
        """
        Navigate to Snapchat web login page.
        """
        logger.info("Navigating to Snapchat...")
        try:
            self.driver.get("https://accounts.snapchat.com/accounts/login")
            time.sleep(3)  # Wait for page to load
            logger.info("Successfully navigated to Snapchat login page")
        except Exception as e:
            logger.error(f"Failed to navigate to Snapchat: {e}")
            raise

    def login(self):
        """
        Perform the login operation.
        """
        logger.info("Attempting to log in...")

        try:
            # Wait for username field
            wait = WebDriverWait(self.driver, 20)

            # Find and fill username field
            username_field = wait.until(
                EC.presence_of_element_located((By.NAME, "username"))
            )
            username_field.clear()
            username_field.send_keys(self.username)
            logger.info("Username entered")
            time.sleep(1)

            # Find and fill password field
            password_field = self.driver.find_element(By.NAME, "password")
            password_field.clear()
            password_field.send_keys(self.password)
            logger.info("Password entered")
            time.sleep(1)

            # Find and click login button
            login_button = self.driver.find_element(By.CSS_SELECTOR, "button[type='submit']")
            login_button.click()
            logger.info("Login button clicked")

            # Wait for login to complete (adjust timeout as needed)
            time.sleep(5)

            # Check if login was successful
            current_url = self.driver.current_url
            logger.info(f"Current URL after login attempt: {current_url}")

            if "login" not in current_url.lower():
                logger.info("Login appears successful!")
                return True
            else:
                logger.warning("Still on login page - may need 2FA or credentials incorrect")
                return False

        except TimeoutException:
            logger.error("Timeout waiting for login elements")
            self.save_screenshot("login_timeout")
            return False
        except NoSuchElementException as e:
            logger.error(f"Could not find login element: {e}")
            self.save_screenshot("element_not_found")
            return False
        except Exception as e:
            logger.error(f"Unexpected error during login: {e}")
            self.save_screenshot("unexpected_error")
            return False

    def save_screenshot(self, name="screenshot"):
        """
        Save a screenshot for debugging purposes.

        Args:
            name (str): Name for the screenshot file
        """
        try:
            filename = f"{name}_{int(time.time())}.png"
            self.driver.save_screenshot(filename)
            logger.info(f"Screenshot saved: {filename}")
        except Exception as e:
            logger.error(f"Failed to save screenshot: {e}")

    def keep_session_alive(self, duration=60):
        """
        Keep the browser session alive for a specified duration.

        Args:
            duration (int): Duration in seconds to keep session alive
        """
        logger.info(f"Keeping session alive for {duration} seconds...")
        time.sleep(duration)

    def close(self):
        """
        Close the browser and clean up resources.
        """
        if self.driver:
            logger.info("Closing browser...")
            self.driver.quit()
            logger.info("Browser closed")

    def run(self, keep_alive=60):
        """
        Execute the complete login workflow.

        Args:
            keep_alive (int): Seconds to keep session alive after login
        """
        try:
            self.setup_driver()
            self.navigate_to_snapchat()

            if self.login():
                logger.info("Successfully logged into Snapchat!")
                self.save_screenshot("successful_login")

                if keep_alive > 0:
                    self.keep_session_alive(keep_alive)
            else:
                logger.error("Login failed")

        except Exception as e:
            logger.error(f"Error in run workflow: {e}")
            raise
        finally:
            self.close()


def main():
    """
    Main entry point for the script.
    """
    import argparse

    parser = argparse.ArgumentParser(description='Snapchat Login Automation for Ubuntu AWS')
    parser.add_argument('--username', help='Snapchat username or email')
    parser.add_argument('--password', help='Snapchat password')
    parser.add_argument('--headless', action='store_true', default=True, help='Run in headless mode')
    parser.add_argument('--visible', action='store_true', help='Run with visible browser')
    parser.add_argument('--keep-alive', type=int, default=60, help='Seconds to keep session alive')

    args = parser.parse_args()

    headless = not args.visible if args.visible else args.headless

    logger.info("Starting Snapchat Login Bot...")
    logger.info(f"Headless mode: {headless}")

    bot = SnapchatLoginBot(
        username=args.username,
        password=args.password,
        headless=headless
    )

    bot.run(keep_alive=args.keep_alive)


if __name__ == "__main__":
    main()

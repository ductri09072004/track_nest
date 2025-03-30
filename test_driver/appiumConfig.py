from appium import webdriver
from appium.options.common.base import AppiumOptions
from appium.webdriver.common.appiumby import AppiumBy
import time
import logging

# For W3C actions
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.actions import interaction
from selenium.webdriver.common.actions.action_builder import ActionBuilder
from selenium.webdriver.common.actions.pointer_input import PointerInput

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

def get_driver():
	options = AppiumOptions()
	options.load_capabilities({
		"appium:automationName": "UiAutomator2",
		"appium:platformName": "Android",
		"appium:deviceName": "aea9ed59",
		"appium:app": "D:/app-development-debug.apk",
		"appium:newCommandTimeout": 3600,
		"appium:connectHardwareKeyboard": True
	})

	logging.info("Đang khởi động Appium và kết nối thiết bị...")
	driver = webdriver.Remote("http://127.0.0.1:4723", options=options)

	return driver
from appium import webdriver
from appium.options.common.base import AppiumOptions
from appium.webdriver.common.appiumby import AppiumBy
import logging
import time
# For W3C actions
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.actions import interaction
from selenium.webdriver.common.actions.action_builder import ActionBuilder
from selenium.webdriver.common.actions.pointer_input import PointerInput

from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

def get_driver():
	options = AppiumOptions()
	options.load_capabilities({
		"appium:automationName": "UiAutomator2",
		"appium:platformName": "Android",
		"appium:deviceName": "aea9ed59",
		"appium:app": "D:/Project/VSCode/track_nest/build/app/outputs/flutter-apk/app-development-debug.apk",
		"appium:newCommandTimeout": 3600,
		"appium:connectHardwareKeyboard": True
	})

	logging.info("Đang khởi động Appium và kết nối thiết bị...")
	driver = webdriver.Remote("http://127.0.0.1:4723", options=options)

	return driver

def click_element(driver, locator, wait_time=5):
    # Hàm hỗ trợ click vào một phần tử với timeout
    try:
        element = WebDriverWait(driver, wait_time).until(
            EC.element_to_be_clickable((AppiumBy.ACCESSIBILITY_ID, locator))
        )
        element.click()
        logging.info(f"Nhấn chọn {locator}")
    except Exception as e:
        logging.error(f"Lỗi khi nhấn chọn vào {locator}: {str(e)}")
    return driver

def input_text(driver, locator, text, wait_time=10):
    #Hàm hỗ trợ nhập văn bản vào một ô nhập
    try:
        element = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().className(\"android.widget.EditText\").instance(0)")
        element.click()
        time.sleep(3)
        element.clear()
        time.sleep(3)
        element.send_keys(text)
        logging.info(f"Nhập {text} vào {locator}")
    except Exception as e:
        logging.error(f"Lỗi khi nhập {text} vào {locator}: {str(e)}")
    return driver
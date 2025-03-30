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

options = AppiumOptions()
options.load_capabilities({
	"appium:automationName": "UiAutomator2",
	"appium:platformName": "Android",
	"appium:deviceName": "aea9ed59",
	"appium:app": "D:/app-development-debug.apk",
	"appium:newCommandTimeout": 3600,
	"appium:connectHardwareKeyboard": True
})

driver = webdriver.Remote("http://127.0.0.1:4723", options=options)

def run_steps():
	logging.info("Đợi ứng dụng tải lên...")

	time.sleep(25)
	logging.info("Bấm vào nút 'Get Started'")
	el1 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"Get Started\").instance(1)")
	el1.click()

	time.sleep(5)
	logging.info("Chọn tab setting trên navbar")
	el2 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Tab 5 of 5")
	el2.click()

	time.sleep(5)
	logging.info("chọn mục category")
	el3 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"Categories\nFor premium\")")
	el3.click()

	time.sleep(5)
	logging.info("chọn quay về setting")
	el4 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.ImageView\").instance(0)")
	el4.click()

	time.sleep(3)
	logging.info("chọn restore account để restore premium")
	el5 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Restore Account")
	el5.click()

	time.sleep(5)
	logging.info("chọn ô nhập mail")
	el7 = driver.find_element(by=AppiumBy.CLASS_NAME, value="android.widget.EditText")
	el7.click()

	time.sleep(3)
	logging.info("nhập mail đã có pre")
	el7.send_keys("tuyettram369@gmail.com")

	time.sleep(5)
	logging.info("ẩn bàn phím")
	driver.execute_script('mobile: hideKeyboard')

	time.sleep(3)
	logging.info("chọn nút find")
	el8 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"Find\").instance(1)")
	el8.click()

	time.sleep(5)
	logging.info("chọn link để liên kết")
	el9 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Link")
	el9.click()

	time.sleep(5)
	logging.info("chọn confirm để xác nhận liên kết")
	el10 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Confirm")
	el10.click()

	time.sleep(5)
	if driver.is_keyboard_shown():
		driver.execute_script('mobile: hideKeyboard')

	time.sleep(3)
	logging.info("nhấn quay lại setting")
	el11 = driver.find_element(by=AppiumBy.CLASS_NAME, value="android.widget.ImageView")
	el11.click()

run_steps()

# driver.closeApp();
# self.driver.reset()
# driver.execute_script('mobile: terminateApp', {'appId': 'com.example.testverygood'})
# driver.terminate_app('com.example.testverygood')
time.sleep(3)
# driver.launchApp()  # Mở lại app
# driver.execute_script('mobile: activateApp ', {'appId': 'com.example.testverygood'})
# driver.activate_app('com.example.testverygood.MainActivity')

run_steps()



# time.sleep(5)
# logging.info("chọn mục category")
# el12 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"Categories\nFor premium\")")
# el12.click()



logging.info("kết thúc automation")
# logging.
driver.quit()
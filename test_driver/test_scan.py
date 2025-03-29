from appium import webdriver
from appium.options.common.base import AppiumOptions
from appium.webdriver.common.appiumby import AppiumBy
import time

# For W3C actions
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.actions import interaction
from selenium.webdriver.common.actions.action_builder import ActionBuilder
from selenium.webdriver.common.actions.pointer_input import PointerInput

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

time.sleep(25)
el1 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Get Started")
el1.click()
time.sleep(5)
el2 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Tab 3 of 5")
el2.click()
time.sleep(5)
el3 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Choose from gallery")
el3.click()
time.sleep(5)
el4 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().resourceId(\"com.google.android.providers.media.module:id/icon_thumbnail\").instance(8)")
el4.click()
time.sleep(10)
el5 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Add to transaction")
el5.click()
time.sleep(10)
el6 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Save")
el6.click()
time.sleep(10)
el7 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"🍚\nEating\n30/8/2022\n-244.500 VND\")")
el7.click()
time.sleep(15)

driver.quit()
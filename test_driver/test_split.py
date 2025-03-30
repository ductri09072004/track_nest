# This sample code supports Appium Python client >=2.3.0
# pip install Appium-Python-Client
# Then you can paste this into a file and simply run with Python

from appium import webdriver
from appium.options.common.base import AppiumOptions
from appium.webdriver.common.appiumby import AppiumBy

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

el1 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"Get Started\").instance(1)")
el1.click()
el2 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Tab 4 of 5")
el2.click()
el3 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Tab 5 of 5")
el3.click()
el4 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Group Friend")
el4.click()
el5 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.ImageView\").instance(1)")
el5.click()
el6 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.EditText\").instance(0)")
el6.click()
el6.send_keys("🍜 Lunch ")
is_keyboard_shown = driver.is_keyboard_shown()
driver.execute_script('mobile: hideKeyboard')
el7 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Add new member")
el7.click()
el8 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.EditText\").instance(2)")
el8.click()
el8.send_keys("Dtri")
el9 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Add new member")
el9.click()
el10 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.EditText\").instance(3)")
el10.click()
el10.send_keys("Mtri")
actions = ActionChains(driver)
actions.w3c_actions = ActionBuilder(driver, mouse=PointerInput(interaction.POINTER_TOUCH, "touch"))
actions.w3c_actions.pointer_action.move_to_location(337, 731)
actions.w3c_actions.pointer_action.pointer_down()
actions.w3c_actions.pointer_action.move_to_location(337, 337)
actions.w3c_actions.pointer_action.release()
actions.perform()

el11 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Add new member")
el11.click()
el12 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.EditText\").instance(4)")
el12.click()
el12.send_keys("Ngan")
el13 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Add new member")
el13.click()
el14 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.EditText\").instance(5)")
el14.click()
el15 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.EditText\").instance(4)")
el15.click()
el15.send_keys("Phuc")
is_keyboard_shown = driver.is_keyboard_shown()
driver.execute_script('mobile: hideKeyboard')
el16 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"Save\").instance(1)")
el16.click()
el17 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.ImageView\").instance(0)")
el17.click()
el18 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.ImageView\").instance(0)")
el18.click()
el19 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Group Friend")
el19.click()
el20 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.ImageView\").instance(0)")
el20.click()
el21 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Tab 4 of 5")
el21.click()
el22 = driver.find_element(by=AppiumBy.CLASS_NAME, value="android.widget.Button")
el22.click()
el23 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"🍜 Lunch\n(6 people)\")")
el23.click()
el24 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Apply")
el24.click()
el25 = driver.find_element(by=AppiumBy.CLASS_NAME, value="android.widget.EditText")
el25.click()
el25.send_keys("164000")
driver.execute_script('mobile: hideKeyboard')
el26 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.Switch\").instance(0)")
el26.click()
el27 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.Switch\").instance(1)")
el27.click()
el28 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.Switch\").instance(2)")
el28.click()
el29 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.Switch\").instance(3)")
el29.click()
el30 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"🍚\nEating\")")
el30.click()
actions = ActionChains(driver)
actions.w3c_actions = ActionBuilder(driver, mouse=PointerInput(interaction.POINTER_TOUCH, "touch"))
actions.w3c_actions.pointer_action.move_to_location(359, 1196)
actions.w3c_actions.pointer_action.pointer_down()
actions.w3c_actions.pointer_action.move_to_location(361, 487)
actions.w3c_actions.pointer_action.release()
actions.perform()

el31 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"Save\").instance(1)")
el31.click()
el32 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.ImageView\").instance(0)")
el32.click()
el33 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Tab 5 of 5")
el33.click()
el34 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Tab 4 of 5")
el34.click()

driver.quit()
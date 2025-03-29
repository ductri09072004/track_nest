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

logging.info("Đang khởi động Appium và kết nối thiết bị...")
driver = webdriver.Remote("http://127.0.0.1:4723", options=options)

# wait = WebDriverWait(driver, 5)  # Chờ tối đa 10 giây cho các phần tử xuất hiện

logging.info("Đợi ứng dụng tải lên...")

time.sleep(25)
logging.info("Bấm vào nút 'Get Started'")
el1 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"Get Started\").instance(1)")
el1.click()

time.sleep(3)
logging.info("Chọn nút thêm giao dịch trên navbar")
el2 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Tab 3 of 5")
el2.click()

time.sleep(3)
logging.info("Chọn thêm giao dịch thủ công")
el3 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Add Manually")
el3.click()

time.sleep(3)
logging.info("Chọn ô nhập số tiền")
el4 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.EditText\").instance(0)")
el4.click()

time.sleep(3)
logging.info("Nhập số tiền là 350k")
el4.send_keys("350000")

time.sleep(3)
logging.info("Kiểm tra bàn phím và ẩn nó")
is_keyboard_shown = driver.is_keyboard_shown()
driver.execute_script('mobile: hideKeyboard')

time.sleep(3)
logging.info("Lướt qua phải để tìm danh mục thích hợp")
actions = ActionChains(driver)
actions.w3c_actions = ActionBuilder(driver, mouse=PointerInput(interaction.POINTER_TOUCH, "touch"))
actions.w3c_actions.pointer_action.move_to_location(607, 737)
actions.w3c_actions.pointer_action.pointer_down()
actions.w3c_actions.pointer_action.move_to_location(100, 735)
actions.w3c_actions.pointer_action.release()
actions.perform()

time.sleep(3)
logging.info("Chọn danh mục Education")
el5 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"📚\nEducation\")")
el5.click()

time.sleep(3)
logging.info("Chọn ngày")
el6 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="29/3/2025")
el6.click()

time.sleep(3)
logging.info("Chọn ngày 23/03/2025")
el7 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="23, Sunday, March 23, 2025")
el7.click()

time.sleep(3)
logging.info("Nhấn ok để cập nhật ngày")
el8 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="OK")
el8.click()

time.sleep(3)
logging.info("kiểm tra bàn phím và ẩn nó")
is_keyboard_shown = driver.is_keyboard_shown()
driver.execute_script('mobile: hideKeyboard')

time.sleep(3)
logging.info("Chọn save để lưu giao dịch")
el9 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Save")
el9.click()

time.sleep(7)
logging.info("Chọn xem chi tiết giao dịch ở trang chủ")
el10 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"📚\nEducation\n23/3/2025\n-350.000 VND\")")
el10.click()

time.sleep(5)
logging.info("Chọn ô nhập tiền và xóa số tiền đã nhập")
el11 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().text(\"350000\")")
el11.click()
el11.clear()

time.sleep(3)
logging.info("Chọn lại ô nhập và nhập số tiền mới 300k")
el12 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.EditText\").instance(0)")
el12.click()
el12.send_keys("300000")

time.sleep(3)
logging.info("Chọn ô ngày và chọn ngày 28/3/2025")
el13 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="29/3/2025")
el13.click()

time.sleep(3)
el14 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="28, Friday, March 28, 2025")
el14.click()

time.sleep(3)
logging.info("nhấn ok để chọn ngày")
el15 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="OK")
el15.click()

time.sleep(3)
logging.info("kiểm tra bàn phím và ẩn nó")
is_keyboard_shown = driver.is_keyboard_shown()
driver.execute_script('mobile: hideKeyboard')

time.sleep(3)
logging.info("Chọn edit để cập nhật giao dịch")
el16 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Edit")
el16.click()

time.sleep(5)
logging.info("chọn lại giao dịch")
el17 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"📚\nEducation\n28/3/2025\n-300.000 VND\")")
el17.click()

time.sleep(5)
logging.info("chọn delete để xóa giao dịch")
el18 = driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Delete")
el18.click()

time.sleep(5)
logging.info("Xong quá trình automation")

driver.quit()
import time
import logging
from selenium.webdriver.common.actions import interaction
from appium.webdriver.common.appiumby import AppiumBy
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.actions.action_builder import ActionBuilder
from selenium.webdriver.common.actions.pointer_input import PointerInput
from appiumConfig import get_driver

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

driver = get_driver()

def run_test():
    try:
        logging.info("Đợi ứng dụng tải lên...")
        time.sleep(25)

        logging.info("Bấm vào nút 'Get Started'")
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"Get Started\").instance(1)").click()

        time.sleep(5)
        logging.info("Chọn nút thêm giao dịch trên navbar")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Tab 3 of 5").click()

        time.sleep(3)
        logging.info("Chọn thêm giao dịch thủ công")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Add Manually").click()

        time.sleep(3)
        logging.info("Chọn ô nhập và điền 350k")
        amount_input = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().className(\"android.widget.EditText\").instance(0)")
        amount_input.click()
        time.sleep(3)
        amount_input.send_keys("350000")

        time.sleep(3)
        if driver.is_keyboard_shown():
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
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"📚\nEducation\")").click()

        time.sleep(3)
        # phải chỉnh ngày cho đúng hnay
        logging.info("Chọn ngày 23/3/2025")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "30/3/2025").click()
        time.sleep(5)
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "23, Sunday, March 23, 2025").click()
        time.sleep(3)
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "OK").click()

        time.sleep(3)
        logging.info("Chọn save để lưu giao dịch")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Save").click()

        time.sleep(5)
        logging.info("Chọn lại giao dịch")
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"📚\nEducation\n23/3/2025\n-350.000 VND\")").click()

        time.sleep(5)
        logging.info("Chọn ô số tiền và xóa")
        value1 = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().text(\"350000\")")
        value1.click()
        time.sleep(3)
        value1.clear()

        time.sleep(5)
        logging.info("nhập số tiền 300k")
        value = driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().className(\"android.widget.EditText\").instance(0)")
        value.click()
        time.sleep(3)
        value.send_keys("300000")

        time.sleep(5)
        # ngày phải đúng hnay
        logging.info("Chọn lại ngày 29/3/2025")
        driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="30/3/2025").click()
        time.sleep(5)
        driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="29, Saturday, March 29, 2025").click()
        time.sleep(5)
        driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="OK").click()

        time.sleep(5)
        logging.info("Chọn edit để cập nhật gd")
        driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Edit").click()

        time.sleep(5)
        logging.info("Chọn lại gd")
        driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"📚\nEducation\n29/3/2025\n-300.000 VND\")").click()

        time.sleep(5)
        logging.info("Chọn delete để xóa giao dịch")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Delete").click()
        time.sleep(10)

        logging.info("Xong automation test CRUD transaction")

    except Exception as e:
        logging.error(f"Lỗi trong quá trình chạy test: {str(e)}")

    finally:
        logging.info("Đóng Appium và kết thúc")
        driver.quit()

# Chạy test
if __name__ == "__main__":
    run_test()

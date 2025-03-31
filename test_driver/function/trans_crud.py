import time
import logging
from selenium.webdriver.common.actions import interaction
from appium.webdriver.common.appiumby import AppiumBy
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.actions.action_builder import ActionBuilder
from selenium.webdriver.common.actions.pointer_input import PointerInput
from appiumConfig import get_driver
from appiumConfig import input_text
from appiumConfig import click_element
from selenium.webdriver.support import expected_conditions as EC

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

driver = get_driver()

def run_test():
    try:
        logging.info("Đợi ứng dụng tải lên...")
        time.sleep(30)
        logging.info("Bấm vào nút 'Get Started'")
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"Get Started\").instance(1)").click()
        time.sleep(3)
        logging.info("Chọn nút thêm giao dịch trên navbar và chọn thêm giao dịch thủ công")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Tab 3 of 5").click()
        time.sleep(3)
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Add Manually").click()
        time.sleep(5)

        logging.info("Lưu với số tiền 350k")
        input_text(driver, "Amount Input", "350000")
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
        click_element(driver, "📚\nEducation")
        time.sleep(2)
        click_element(driver, "Save")

        time.sleep(5)
        logging.info("Chọn lại giao dịch")
        click_element(driver, "ExpenseRow")
        time.sleep(3)

        logging.info("Lưu với số tiền 300k")
        input_text(driver, "Amount Input", "350000")
        time.sleep(3)
        logging.info("Chọn lại ngày 30/3/2025")
        click_element(driver, "31/3/2025")
        time.sleep(2)
        click_element(driver, "30, Sunday, March 30, 2025")
        time.sleep(2)
        click_element(driver, "OK")
        time.sleep(2)
        click_element(driver, "Edit")
        time.sleep(5)

        # time.sleep(5)
        # # ngày phải đúng hnay
        # logging.info("Chọn lại ngày 29/3/2025")
        # driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="30/3/2025").click()
        # time.sleep(5)
        # driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="29, Saturday, March 29, 2025").click()
        # time.sleep(5)
        # driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="OK").click()

        # time.sleep(5)
        # logging.info("Chọn edit để cập nhật gd")
        # driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Edit").click()

        time.sleep(5)
        logging.info("Chọn lại gd")
        driver.find_element(by=AppiumBy.ANDROID_UIAUTOMATOR, value="new UiSelector().description(\"📚\nEducation\n30/3/2025\n-300.000 VND\")").click()

        time.sleep(5)
        logging.info("Chọn delete để xóa giao dịch")
        click_element(driver, "Delete")
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

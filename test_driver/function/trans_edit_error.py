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
        time.sleep(25)
        logging.info("Bấm vào nút 'Get Started'")
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"Get Started\").instance(1)").click()
        time.sleep(5)
        logging.info("Chọn nút thêm giao dịch trên navbar và chọn thêm giao dịch thủ công")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Tab 3 of 5").click()
        time.sleep(3)
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Add Manually").click()
        time.sleep(5)

        logging.info("Lưu với số tiền 350k, có danh mục")
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
        click_element(driver, "Save")
        time.sleep(5)

        click_element(driver, "📚\nEducation\n31/3/2025\n-350.000 VND")

        logging.info("Lưu với số tiền 0k")
        input_text(driver, "Amount Input", "0")
        time.sleep(3)
        click_element(driver, "Edit")
        time.sleep(5)

        logging.info("Lưu với số tiền -90k")
        input_text(driver, "Amount Input", "-90000")
        time.sleep(3)
        click_element(driver, "Edit")
        time.sleep(5)

        logging.info("Lưu với số tiền 0aab2")
        input_text(driver, "Amount Input", "0aab2")
        time.sleep(3)
        click_element(driver, "Edit")
        time.sleep(5)

        logging.info("Lưu với ngày trong tương lai")
        input_text(driver, "Amount Input", "350000")
        time.sleep(5)
        logging.info("Chọn lại ngày 2/4/2025")
        click_element(driver, "1/4/2025")
        time.sleep(2)
        click_element(driver, "2, Tuesday, April 2, 2025")
        time.sleep(2)
        click_element(driver, "OK")
        time.sleep(2)
        click_element(driver, "Edit")

        logging.info("Lưu với số tiền 300k")
        input_text(driver, "Amount Input", "300000")
        time.sleep(3)
        click_element(driver, "Edit")
        time.sleep(5)

        if driver.is_keyboard_shown():
            driver.execute_script('mobile: hideKeyboard')
        time.sleep(5)

        logging.info("Xong automation test ERROR transaction")

    except Exception as e:
        logging.error(f"Lỗi trong quá trình chạy test: {str(e)}")

    finally:
        logging.info("Đóng Appium và kết thúc")
        driver.quit()

# Chạy test
if __name__ == "__main__":
    run_test()

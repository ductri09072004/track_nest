import time
import logging
from appium.webdriver.common.appiumby import AppiumBy
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
        logging.info("Chọn tab setting trên navbar")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Tab 5 of 5").click()

        time.sleep(5)
        logging.info("Chọn mục category")
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"Categories\nFor premium\")").click()

        time.sleep(5)
        logging.info("Quay về setting")
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().className(\"android.widget.ImageView\").instance(0)").click()

        time.sleep(3)
        logging.info("Chọn restore account để restore premium")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Restore Account").click()

        time.sleep(5)
        logging.info("Nhập email")
        email_input = driver.find_element(AppiumBy.CLASS_NAME, "android.widget.EditText")
        email_input.click()
        time.sleep(3)
        email_input.send_keys("tuyettram369@gmail.com")

        time.sleep(5)
        logging.info("Ẩn bàn phím")
        driver.execute_script('mobile: hideKeyboard')

        time.sleep(3)
        logging.info("Nhấn nút Find")
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"Find\").instance(1)").click()

        time.sleep(5)
        logging.info("Chọn link để liên kết")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Link").click()

        time.sleep(5)
        logging.info("Xác nhận liên kết")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Confirm").click()

        time.sleep(5)
        if driver.is_keyboard_shown():
            driver.execute_script('mobile: hideKeyboard')

        time.sleep(3)
        logging.info("Quay lại setting")
        driver.find_element(AppiumBy.CLASS_NAME, "android.widget.ImageView").click()

        logging.info("Xong automation test restore premium")

    except Exception as e:
        logging.error(f"Lỗi trong quá trình chạy test: {str(e)}")

    finally:
        logging.info("Đóng Appium và kết thúc")
        driver.quit()

# Chạy test case
run_test()

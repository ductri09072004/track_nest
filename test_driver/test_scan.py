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
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Get Started").click()

        time.sleep(5)
        logging.info("Chọn tab giao dịch trên navbar")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Tab 3 of 5").click()

        time.sleep(5)
        logging.info("Chọn 'Choose from gallery'")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Choose from gallery").click()

        time.sleep(5)
        logging.info("Chọn ảnh từ thư viện")
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().resourceId(\"com.google.android.providers.media.module:id/icon_thumbnail\").instance(8)").click()

        time.sleep(10)
        logging.info("Thêm ảnh vào giao dịch")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Add to transaction").click()

        time.sleep(10)
        logging.info("Lưu giao dịch")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Save").click()

        time.sleep(10)
        logging.info("Kiểm tra lại giao dịch đã lưu")
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"🍚\nEating\n30/8/2022\n-244.500 VND\")").click()

        time.sleep(15)
        logging.info("Xong automation test scan bill")

    except Exception as e:
        logging.error(f"Lỗi trong quá trình test: {str(e)}")

    finally:
        logging.info("Đóng Appium và kết thúc")
        driver.quit()

# Chạy test
if __name__ == "__main__":
    run_test()

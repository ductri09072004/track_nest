import time
import logging
from appium.webdriver.common.appiumby import AppiumBy
from appiumConfig import get_driver
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.actions.action_builder import ActionBuilder
from selenium.webdriver.common.actions.pointer_input import PointerInput
from appiumConfig import input_text
from appiumConfig import click_element
from selenium.webdriver.common.actions import interaction

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

driver = get_driver()

def run_test():
    try:
        logging.info("Đợi ứng dụng tải lên...")
        time.sleep(10)
        logging.info("Bấm vào nút 'Get Started'")
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"Get Started\").instance(1)").click()
        time.sleep(5)

        # Mở ứng dụng và chọn tab 5
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Get Started").click()
        time.sleep(2)
        # driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Tab 4 of 5").click()
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Tab 5 of 5").click()
        time.sleep(2)

        # Chọn nhóm bạn bè
        logging.info("📌 Chọn nhóm 'Group Friend'")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Group Friend").click()

        # Nhập tên nhóm
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().className(\"android.widget.ImageView\").instance(1)").click()
        input_field = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().className(\"android.widget.EditText\").instance(0)")
        input_field.click()
        input_field.send_keys("🍜 Lunch ")
        driver.execute_script('mobile: hideKeyboard')

        # Thêm thành viên vào nhóm
        logging.info("👥 Thêm thành viên vào nhóm")
        member_names = ["Dtri", "Mtri", "Ngan", "Phuc"]
        for index, name in enumerate(member_names, start=2):
            driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Add new member").click()
            input_field = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, f"new UiSelector().className(\"android.widget.EditText\").instance({index})")
            input_field.click()
            input_field.send_keys(name)
            time.sleep(1)

        driver.execute_script('mobile: hideKeyboard')
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"Save\").instance(1)").click()

        # Chọn giao dịch nhóm
        logging.info("💰 Chọn giao dịch nhóm '🍜 Lunch'")
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Tab 4 of 5").click()
        driver.find_element(AppiumBy.CLASS_NAME, "android.widget.Button").click()
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"🍜 Lunch\n(6 people)\")").click()
        driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Apply").click()

        # Nhập số tiền
        logging.info("💵 Nhập số tiền 164,000 VND")
        amount_field = driver.find_element(AppiumBy.CLASS_NAME, "android.widget.EditText")
        amount_field.click()
        amount_field.send_keys("164000")
        driver.execute_script('mobile: hideKeyboard')

        # Chọn danh mục ăn uống
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"🍚\nEating\")").click()

        # Kéo màn hình lên
        logging.info("📜 Kéo màn hình lên")
        actions = ActionChains(driver)
        actions.w3c_actions = ActionBuilder(driver, mouse=PointerInput(interaction.POINTER_TOUCH, "touch"))
        actions.w3c_actions.pointer_action.move_to_location(359, 1196)
        actions.w3c_actions.pointer_action.pointer_down()
        actions.w3c_actions.pointer_action.move_to_location(361, 487)
        actions.w3c_actions.pointer_action.release()
        actions.perform()

        # Lưu giao dịch
        logging.info("✅ Lưu giao dịch nhóm")
        driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().description(\"Save\").instance(1)").click()

        logging.info("Xong automation test split transaction")

    except Exception as e:
        logging.error(f"Lỗi trong quá trình chạy test: {str(e)}")

    finally:
        logging.info("Đóng Appium và kết thúc")
        driver.quit()

# Chạy test
if __name__ == "__main__":
    run_test()

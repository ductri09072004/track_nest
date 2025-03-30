from appium import webdriver
from appium.webdriver.common.appiumby import AppiumBy
import time

def main():
    caps = {
        "platformName": "Android",
        "automationName": "UiAutomator2",
        "deviceName": "9bd849c9",
        "app": "E:/Flutter/track_nest/build/app/outputs/flutter-apk/app-development-debug.apk",
        "noReset": True,
        "fullReset": False,
        "newCommandTimeout": 3600,
        "connectHardwareKeyboard": True
    }

    driver = webdriver.Remote("http://127.0.0.1:4723/wd/hub", caps)

    def wait_and_click(locator_type, locator_value, delay=3):
        """Tìm kiếm phần tử và nhấp vào, sau đó chờ một khoảng thời gian."""
        element = driver.find_element(locator_type, locator_value)
        element.click()
        time.sleep(delay)

    wait_and_click(AppiumBy.ANDROID_UIAUTOMATOR, 'new UiSelector().description("Get Started").instance(1)')
    wait_and_click(AppiumBy.ANDROID_UIAUTOMATOR, 'new UiSelector().className("android.widget.Button").instance(1)')
    wait_and_click(AppiumBy.ANDROID_UIAUTOMATOR, 'new UiSelector().className("android.widget.Button").instance(1)')
    wait_and_click(AppiumBy.ACCESSIBILITY_ID, "Scan_Btn")
    wait_and_click(AppiumBy.ACCESSIBILITY_ID, "Choose from gallery")

    wait_and_click(AppiumBy.ANDROID_UIAUTOMATOR, 'new UiSelector().resourceId("com.android.providers.media.module:id/icon_thumbnail").instance(10)', delay=6)
    wait_and_click(AppiumBy.ACCESSIBILITY_ID, "Scan bill again")
    wait_and_click(AppiumBy.ACCESSIBILITY_ID, "Choose from gallery")

    wait_and_click(AppiumBy.ANDROID_UIAUTOMATOR, 'new UiSelector().resourceId("com.android.providers.media.module:id/icon_thumbnail").instance(6)', delay=5)
    wait_and_click(AppiumBy.ACCESSIBILITY_ID, "Add to transaction", delay=6)

    wait_and_click(AppiumBy.ACCESSIBILITY_ID, "Income")
    wait_and_click(AppiumBy.ACCESSIBILITY_ID, "3/4/2018")
    wait_and_click(AppiumBy.ACCESSIBILITY_ID, "18, Wednesday, April 18, 2018")
    wait_and_click(AppiumBy.ACCESSIBILITY_ID, "OK")
    wait_and_click(AppiumBy.ANDROID_UIAUTOMATOR, 'new UiSelector().className("android.widget.ImageView").instance(3)')
    wait_and_click(AppiumBy.ANDROID_UIAUTOMATOR, 'new UiSelector().resourceId("com.android.providers.media.module:id/icon_thumbnail").instance(11)')
    wait_and_click(AppiumBy.ACCESSIBILITY_ID, "Save")
    wait_and_click(AppiumBy.ACCESSIBILITY_ID, "Statis_Btn")
    wait_and_click(AppiumBy.ACCESSIBILITY_ID, "Income")

    driver.quit()

if __name__ == "__main__":
    main()

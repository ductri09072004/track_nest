const { remote } = require('webdriverio');
const { testScroll } = require("./components/help.js");

async function delay(time) {
  return new Promise(resolve => setTimeout(resolve, time));
}

async function clickElementLow(driver, selector, description, successLog) {
  try {
    const element = await driver.$(selector);
    await element.click();
    successLog.push(`✅ ${description}`);
  } catch (error) {
    successLog.push(`❌ ${description} - Lỗi: ${error.message}`);
  }
  await delay(5000);
}

async function clickElement(driver, selector, description, successLog) {
  try {
    const element = await driver.$(selector);
    await element.click();
    successLog.push(`✅ ${description}`);
  } catch (error) {
    successLog.push(`❌ ${description} - Lỗi: ${error.message}`);
  }
  await delay(3000);
}

async function inputText(driver, selector, text, description, successLog) {
  try {
    const element = await driver.$(selector);
    await element.click();
    await element.setValue(text);
    successLog.push(`✅ Nhập "${text}" vào ${description}`);
  } catch (error) {
    successLog.push(`❌ ${description} - Lỗi: ${error.message}`);
  }
  await delay(3000);
}


async function main() {
  const caps = {
    "appium:automationName": "UiAutomator2",
    "appium:platformName": "Android",
    "appium:deviceName": "9bd849c9",
    "appium:app": "E:/Flutter/track_nest/build/app/outputs/flutter-apk/app-development-debug.apk",
    "appium:noReset": true,
    "appium:fullReset": false,
    "appium:newCommandTimeout": 3600,
    "appium:connectHardwareKeyboard": true
  };

  const driver = await remote({
    protocol: "http",
    hostname: "127.0.0.1",
    port: 4723,
    path: "/",
    capabilities: caps
  });

  let successLog = [];

  await clickElement(driver, "-android uiautomator:new UiSelector().description(\"Get Started\").instance(1)", "Nút Get Started", successLog);
  await clickElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.Button\").instance(1)", "Kéo màn hình lên", successLog);
  await clickElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.Button\").instance(1)", "Kéo màn hình xuống", successLog);

  await testScroll(driver, "Transactions");
  await delay(3000);

  await clickElement(driver, "accessibility id:Scan_Btn", "Nút Scan", successLog);
  await clickElement(driver, "accessibility id:Choose from gallery", "Chọn ảnh từ thư viện", successLog);
  await clickElementLow(driver, "-android uiautomator:new UiSelector().resourceId(\"com.android.providers.media.module:id/icon_thumbnail\").instance(10)", "Chọn ảnh thứ 10", successLog);

  await clickElement(driver, "accessibility id:Scan bill again", "Quét lại hóa đơn", successLog);
  await clickElement(driver, "accessibility id:Choose from gallery", "Chọn ảnh từ thư viện", successLog);
  await clickElementLow(driver, "-android uiautomator:new UiSelector().resourceId(\"com.android.providers.media.module:id/icon_thumbnail\").instance(6)", "Chọn ảnh thứ 6", successLog);
  await clickElementLow(driver, "accessibility id:Add to transaction", "Thêm vào giao dịch", successLog);

  await clickElementLow(driver, "accessibility id:Income", "Chọn mục Income", successLog);
  await clickElement(driver, "accessibility id:3/4/2018", "Chọn ngày 3/4/2018", successLog);
  await clickElement(driver, "accessibility id:18, Wednesday, April 18, 2018", "Chọn ngày 18/4/2018", successLog);
  await clickElement(driver, "accessibility id:OK", "Xác nhận OK", successLog);
  await clickElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(3)", "Mở trình chọn ảnh", successLog);
  await clickElementLow(driver, "-android uiautomator:new UiSelector().resourceId(\"com.android.providers.media.module:id/icon_thumbnail\").instance(11)", "Chọn ảnh thứ 11", successLog);
  await clickElementLow(driver, "accessibility id:Save", "Lưu giao dịch", successLog);
  await clickElement(driver, "accessibility id:Statis_Btn", "Mở thống kê", successLog);
  await clickElement(driver, "accessibility id:Income", "Lọc theo Income", successLog);
  await clickElement(driver, "accessibility id:Setting_Btn", "Mở cài đặt", successLog);
  await clickElement(driver, "accessibility id:Group Friend", "Mở Group Friend", successLog);
  await clickElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(1)", "Chọn ảnh nhóm", successLog);


  await inputText(driver, "-android uiautomator:new UiSelector().className(\"android.widget.EditText\").instance(0)", "Matcha Latte", "Tên nhóm", successLog);
  await clickElement(driver, "accessibility id:Add new member", "Thêm thành viên", successLog);
  await inputText(driver, "-android uiautomator:new UiSelector().className(\"android.widget.EditText\").instance(2)", "Trí", "Thành viên 1", successLog);
  await clickElement(driver, "accessibility id:Add new member", "Thêm thành viên", successLog);
  await inputText(driver, "-android uiautomator:new UiSelector().className(\"android.widget.EditText\").instance(3)", "Quỳnh", "Thành viên 2", successLog);
  
  await clickElement(driver, "-android uiautomator:new UiSelector().description(\"Save\").instance(1)", "Lưu nhóm", successLog);
 
  await clickElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(0)", "Click nút back", successLog);
  await clickElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(0)", "Click nút back", successLog);



  await driver.deleteSession();

  console.log("\n===== KẾT QUẢ BÀI TEST =====");
  successLog.forEach(log => console.log(log));

  // Đếm số bước thành công và thất bại
  const totalSteps = successLog.length;
  const failedSteps = successLog.filter(log => log.startsWith("❌")).length;
  const successRate = ((totalSteps - failedSteps) / totalSteps) * 100;

  if (failedSteps > totalSteps * 0.5) {
    console.log("❌ Kết quả bài test: FAIL (Quá 50% bước bị lỗi)");
  } else {
    console.log("✅ Kết quả bài test: PASS");
  }

  console.log("✅ Kết thúc phiên test thành công!");
}

main().catch(error => console.log(`❌ Lỗi tổng thể: ${error.message}`));

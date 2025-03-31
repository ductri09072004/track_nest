const { remote } = require('webdriverio');
const { testScroll } = require("./components/help.js");

async function delay(time) {
  return new Promise(resolve => setTimeout(resolve, time));
}

async function clickElementLow(driver, selector, description, successLog) {
  try {
    const element = await driver.$(selector);
    await element.click();
    successLog.push({ step: description, status: "✅ Thành công" });
  } catch (error) {
    successLog.push({ step: description, status: `❌ Thất bại - ${error.message}` });
  }
  await delay(5000);
}

async function clickElement(driver, selector, description, successLog) {
  try {
    const element = await driver.$(selector);
    await element.click();
    successLog.push({ step: description, status: "✅ Thành công" });
  } catch (error) {
    successLog.push({ step: description, status: `❌ Thất bại - ${error.message}` });
  }
  await delay(3000);
}

async function inputText(driver, selector, text, description, successLog) {
  try {
    const element = await driver.$(selector);
    await element.click();
    await element.setValue(text);
    successLog.push({ step: `Nhập \"${text}\" vào ${description}`, status: "✅ Thành công" });
  } catch (error) {
    successLog.push({ step: description, status: `❌ Thất bại - ${error.message}` });
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

  await driver.deleteSession();

  console.log("\n=========================");
  console.log("📋 KẾT QUẢ TEST:");
  console.log("=========================");
  successLog.forEach((log, index) => {
    console.log(`${index + 1}. ${log.step}: ${log.status}`);
  });
  console.log("=========================");
  console.log(`🎯 Tổng số bước kiểm tra: ${successLog.length}`);
  console.log(`✅ Thành công: ${successLog.filter(log => log.status.includes("✅")).length}`);
  console.log(`❌ Thất bại: ${successLog.filter(log => log.status.includes("❌")).length}`);
  console.log("=========================");
  console.log(successLog.every(log => log.status.includes("✅")) ? "🎉 TẤT CẢ CÁC BƯỚC ĐỀU THÀNH CÔNG! 🎉" : "⚠️ CÓ LỖI TRONG QUÁ TRÌNH TEST! ⚠️");
  console.log("=========================");
}

main().catch(error => {
  console.log("=========================");
  console.log(`❌ Lỗi tổng thể: ${error.message}`);
  console.log("=========================");
});

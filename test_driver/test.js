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

async function testUIElement(driver, selector, description, successLog) {
  try {
    const element = await driver.$(selector);
    successLog.push(`👍 ${description}`);
  } catch (error) {
    successLog.push(`❌ ${description} - Lỗi: ${error.message}`);
  }
  await delay(3000);
}

async function testPosition(driver, selector, expectedX, expectedY, description, successLog) {
  try {
    const element = await driver.$(selector);
    const location = await element.getLocation();

    const { x, y } = location;

    const xMatch = Math.abs(x - expectedX) <= 5;
    const yMatch = Math.abs(y - expectedY) <= 5;

    if (xMatch && yMatch) {
      successLog.push(`✅ ${description} - Vị trí đúng (X: ${x}, Y: ${y})`);
    } else {
      successLog.push(`❌ ${description} - Vị trí sai 
      (Nhận: X: ${x}, Y: ${y}, Mong đợi: X: ${expectedX}, Y: ${expectedY})`);
    }
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
  await testUIElement(driver, "-android uiautomator:new UiSelector().description(\"Get Started\").instance(1)", "Hiện nút Get Started", successLog);
  await testPosition(driver, 
    "-android uiautomator:new UiSelector().description(\"Get Started\").instance(1)", 
    60, 2505, // Chỉ kiểm tra X, Y
    "Kiểm tra vị trí của nút Get Started", 
    successLog
  );

  await clickElement(driver, "-android uiautomator:new UiSelector().description(\"Get Started\").instance(1)", "Đã bấm nút Get Started", successLog);

  await clickElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.Button\").instance(1)", "Kéo màn hình lên", successLog);
  await clickElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.Button\").instance(1)", "Kéo màn hình xuống", successLog);

  await testScroll(driver, "Transactions");
  await delay(3000);

  await testUIElement(driver, "accessibility id:Scan_Btn", "Hiện nút Scan", successLog);
  await testPosition(driver, 
    "accessibility id:Scan_Btn", 
    488, 2451, // Chỉ kiểm tra X, Y
    "Hiện nút Scan", 
    successLog
  );
  await clickElement(driver, "accessibility id:Scan_Btn", "Bấm vào nút Scan", successLog);

  await testUIElement(driver, "accessibility id:Choose from gallery", "Hiện nút chọn ảnh", successLog);
  await testPosition(driver, 
    "accessibility id:Choose from gallery", 
    36, 1839, // Chỉ kiểm tra X, Y
    "Hiện nút gallery", 
    successLog
  );
  await clickElement(driver, "accessibility id:Choose from gallery", "Chọn ảnh từ thư viện", successLog);
  await clickElementLow(driver, "-android uiautomator:new UiSelector().resourceId(\"com.android.providers.media.module:id/icon_thumbnail\").instance(10)", "Chọn ảnh thứ 10", successLog);

  await testUIElement(driver, "accessibility id:Scan bill again", "Hiện nút quét lại hóa đơn", successLog);
  await testPosition(driver, 
    "accessibility id:Scan bill again", 
    816, 2226, // Chỉ kiểm tra X, Y
    "Hiện chọn lại ảnh", 
    successLog
  );
  await clickElement(driver, "accessibility id:Scan bill again", "Bấm quét lại hóa đơn", successLog);

  await testUIElement(driver, "accessibility id:Choose from gallery", "Hiện nút chọn ảnh từ thư viện", successLog);
  await clickElement(driver, "accessibility id:Choose from gallery", "Chọn ảnh từ thư viện", successLog);
  await clickElementLow(driver, "-android uiautomator:new UiSelector().resourceId(\"com.android.providers.media.module:id/icon_thumbnail\").instance(6)", "Chọn ảnh thứ 6", successLog);

  await testUIElement(driver, "accessibility id:Add to transaction", "Hiện nút thêm vào giao dịch", successLog);
  await testPosition(driver, 
    "accessibility id:Add to transaction", 
    434, 2226, // Chỉ kiểm tra X, Y
    "Hiện nút thêm ảnh", 
    successLog
  );
  await clickElementLow(driver, "accessibility id:Add to transaction", "Bấm vào thêm vào giao dịch", successLog);

  await testUIElement(driver, "accessibility id:Income", "Hiện nút chọn mục Income", successLog);
  await testPosition(driver, 
    "accessibility id:Income", 
    610, 334, // Chỉ kiểm tra X, Y
    "Hiện đổi Income", 
    successLog
  );
  await clickElementLow(driver, "accessibility id:Income", "Chọn mục Income", successLog);

  await testUIElement(driver, "accessibility id:3/4/2018", "Hiện nút chọn ngày", successLog);
  await testPosition(driver, 
    "accessibility id:3/4/2018", 
    60, 1536, // Chỉ kiểm tra X, Y
    "Hiện nút chọn ngày", 
    successLog
  );
  await clickElement(driver, "accessibility id:3/4/2018", "Chọn ngày 3/4/2018", successLog);
  await clickElement(driver, "accessibility id:18, Wednesday, April 18, 2018", "Chọn ngày 18/4/2018", successLog);
  await clickElement(driver, "accessibility id:OK", "Xác nhận OK", successLog);

  await testUIElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(3)", "Hiện nút chọn trình chọn ảnh", successLog);
  await testPosition(driver, 
    "-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(3)", 
    336, 1978, // Chỉ kiểm tra X, Y
    "Hiện nút chọn ảnh", 
    successLog
  );
  await clickElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(3)", "Mở trình chọn ảnh", successLog);
  await clickElementLow(driver, "-android uiautomator:new UiSelector().resourceId(\"com.android.providers.media.module:id/icon_thumbnail\").instance(11)", "Chọn ảnh thứ 11", successLog);

  await testUIElement(driver, "accessibility id:Save", "Hiện nút lưu giao dịch", successLog);
  await testPosition(driver, 
    "accessibility id:Save", 
    60, 2502, // Chỉ kiểm tra X, Y
    "Hiện nút save transaction", 
    successLog
  );
  await clickElementLow(driver, "accessibility id:Save", "Lưu giao dịch", successLog);

  await testUIElement(driver, "accessibility id:Statis_Btn", "Hiện nút thống kê", successLog);
  await testPosition(driver, 
    "accessibility id:Statis_Btn", 
    244, 2493, // Chỉ kiểm tra X, Y
    "Hiện nút statistical", 
    successLog
  );
  await clickElement(driver, "accessibility id:Statis_Btn", "Mở thống kê", successLog);

  await testUIElement(driver, "accessibility id:Income", "Hiện nút lọc theo Income", successLog);
  await clickElement(driver, "accessibility id:Income", "Lọc theo Income", successLog);

  await testUIElement(driver, "accessibility id:Setting_Btn", "Hiện nút cài đặt", successLog);
  await clickElement(driver, "accessibility id:Setting_Btn", "Mở cài đặt", successLog);

  await testUIElement(driver, "accessibility id:Group Friend", "Hiện nút Group Friend", successLog);
  await clickElement(driver, "accessibility id:Group Friend", "Mở Group Friend", successLog);

  await testUIElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(1)", "Hiện nút thêm nhóm", successLog);
  await clickElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(1)", "Chọn thêm nhóm", successLog);

  await testUIElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.EditText\").instance(0)", "Hiện input tên nhóm", successLog);
  await inputText(driver, "-android uiautomator:new UiSelector().className(\"android.widget.EditText\").instance(0)", "Matcha Latte", "Nhấn vào thêm tên nhóm", successLog);

  await testUIElement(driver, "accessibility id:Add new member", "Hiện nút thêm thành viên", successLog);
  await clickElement(driver, "accessibility id:Add new member", "Thêm thành viên", successLog);

  await testUIElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.EditText\").instance(2)", "Hiện input thêm thành viên", successLog);
  await inputText(driver, "-android uiautomator:new UiSelector().className(\"android.widget.EditText\").instance(2)", "Trí", "Thành viên 1", successLog);

  await testUIElement(driver, "accessibility id:Add new member", "Hiện nút thêm thành viên", successLog);
  await clickElement(driver, "accessibility id:Add new member", "Thêm thành viên", successLog);
  await inputText(driver, "-android uiautomator:new UiSelector().className(\"android.widget.EditText\").instance(3)", "Quỳnh", "Thành viên 2", successLog);

  await testUIElement(driver, "-android uiautomator:new UiSelector().description(\"Save\").instance(1)", "Hiện nút lưu nhóm", successLog);
  await clickElement(driver, "-android uiautomator:new UiSelector().description(\"Save\").instance(1)", "Lưu nhóm", successLog);

  await testUIElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(0)", "Hiện nút back", successLog);
  await clickElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(0)", "Nhấn nút back", successLog);
  await clickElement(driver, "-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(0)", "Nhấn nút back", successLog);

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

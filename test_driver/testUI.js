const { remote } = require('webdriverio');
const { testScroll } = require("./components/help.js");

async function delay(time) {
  return new Promise(resolve => setTimeout(resolve, time));
}


async function testPosition(driver, selector, expectedXPercent, expectedYPercent, description, successLog) {
  try {
    const element = await driver.$(selector);
    const location = await element.getLocation();
    const { width, height } = await driver.getWindowRect(); // Lấy kích thước màn hình

    const xPercent = (location.x / width) * 100;
    const yPercent = (location.y / height) * 100;

    // Kiểm tra vị trí trong phạm vi sai số 2%
    const xMatch = Math.abs(xPercent - expectedXPercent) <= 2;
    const yMatch = Math.abs(yPercent - expectedYPercent) <= 2;

    if (xMatch && yMatch) {
      successLog.push(`✅ ${description} - Vị trí đúng (X: ${xPercent.toFixed(2)}%, Y: ${yPercent.toFixed(2)}%)`);
    } else {
      successLog.push(`❌ ${description} - Vị trí sai 
      (Nhận: X: ${xPercent.toFixed(2)}%, Y: ${yPercent.toFixed(2)}%, 
      Mong đợi: X: ${expectedXPercent}%, Y: ${expectedYPercent}%)`);
    }
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

    // Kiểm tra tọa độ có nằm trong phạm vi mong muốn không
    const xMatch = Math.abs(x - expectedX) <= 5; // Sai số nhỏ
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

  await testPosition(driver, 
    "accessibility id:Statis_Btn", 
    244, 2493, // Chỉ kiểm tra X, Y
    "Hiện nút statistical", 
    successLog
  );

  //await testUIElement(driver, "accessibility id:Choose from gallery", "Hiện nút chọn ảnh", successLog);
  

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

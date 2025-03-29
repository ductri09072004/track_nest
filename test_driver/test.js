const wdio = require("webdriverio");

async function createDriver() {
  const opts = {
    hostname: "localhost",
    port: 4723,
    path: "/",
    capabilities: {
      platformName: "Android",
      "appium:deviceName": "9bd849c9",
      "appium:app": "E:/Flutter/track_nest/build/app/outputs/flutter-apk/app-development-debug.apk",
      "appium:automationName": "UiAutomator2",
      "appium:noReset": true,
      "appium:fullReset": false,
    },
  };

  console.log("🚀 Đang kết nối với Appium...");
  return await wdio.remote(opts);
}

async function testTextByContent(driver, text) {
  console.log(`🔍 Đang tìm text '${text}'...`);
  const element = await driver.$(`android=new UiSelector().text("${text}")`);

  if (await element.isDisplayed()) {
    console.log(`✅ Text '${text}' đã hiển thị!`);
  } else {
    throw new Error(`❌ Text '${text}' không hiển thị!`);
  }
}

async function testTextClick2(driver, text) {
  console.log(`🔍 Đang tìm text '${text}'...`);
  const element = await driver.$(`android=new UiSelector().text("${text}")`);

  if (await element.isDisplayed()) {
    console.log(`✅ Text '${text}' đã hiển thị!`);
    
    await element.click();
    console.log(`🖱️ Đã click vào '${text}'!`);
  } else {
    throw new Error(`❌ Text '${text}' không hiển thị!`);
  }
}


async function main() {
  const driver = await createDriver();

  try {
    await testTextClick2(driver, "Get Started");    

  } catch (error) {
    console.error("❌ Lỗi khi thực hiện test:", error);
  } finally {
    await driver.deleteSession();
  }
}

main();

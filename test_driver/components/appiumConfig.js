const wdio = require("webdriverio");

async function createDriver() {
  const opts = {
    hostname: "localhost",
    port: 4723,
    path: "/",
    capabilities: {
      platformName: "Android",
      "appium:deviceName": "9bd849c9",
      "appium:app": "D:/Project/VSCode/track_nest/build/app/outputs/flutter-apk/app-development-debug.apk",
      "appium:automationName": "UiAutomator2",
      // "appium:noReset": true,
      // "appium:fullReset": false,
    },
  };

  console.log("🚀 Đang kết nối với Appium...");
  return await wdio.remote(opts);
}

module.exports = { createDriver };

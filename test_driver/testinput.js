const { remote } = require('webdriverio');
const { testScroll } = require("./components/help.js");

async function main () {
  const caps = {
  "appium:automationName": "UiAutomator2",
  "appium:platformName": "Android",
  "appium:deviceName": "9bd849c9",
  "appium:app": "E:/Flutter/track_nest/build/app/outputs/flutter-apk/app-development-debug.apk",
  "appium:noReset": true,
  "appium:fullReset": false,
  "appium:newCommandTimeout": 3600,
  "appium:connectHardwareKeyboard": true
}
  const driver = await remote({
    protocol: "http",
    hostname: "127.0.0.1",
    port: 4723,
    path: "/",
    capabilities: caps
  });
  const el1 = await driver.$("accessibility id:His_Btn");
  await el1.click();
  await driver.pause(3000);
  const el2 = await driver.$("-android uiautomator:new UiSelector().className(\"android.widget.Button\").instance(0)");
  await el2.click();
  await driver.pause(3000);
  const el3 = await driver.$("-android uiautomator:new UiSelector().description(\"Viuss\n(6 people)\")");
  await el3.click();
  await driver.pause(3000);
  const el4 = await driver.$("accessibility id:Apply");
  await el4.click();
  const el5 = await driver.$("-android uiautomator:new UiSelector().className(\"android.widget.EditText\").instance(0)");
  await el5.click();
  const el6 = await driver.$("-android uiautomator:new UiSelector().className(\"android.widget.Switch\").instance(0)");
  await el6.click();
  const el7 = await driver.$("-android uiautomator:new UiSelector().className(\"android.widget.Switch\").instance(1)");
  await el7.click();
  const el8 = await driver.$("-android uiautomator:new UiSelector().description(\"📺\nEntertainment\")");
  await el8.click();
  const el9 = await driver.$("accessibility id:30/3/2025");
  await el9.click();
  const el10 = await driver.$("accessibility id:19, Wednesday, March 19, 2025");
  await el10.click();
  const el11 = await driver.$("accessibility id:OK");
  await el11.click();
  const el12 = await driver.$("-android uiautomator:new UiSelector().className(\"android.widget.EditText\").instance(1)");
  await el12.click();
  const el13 = await driver.$("-android uiautomator:new UiSelector().description(\"Save\").instance(1)");
  await el13.click();
  const el14 = await driver.$("-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(0)");
  await el14.click();
  await driver.deleteSession();
}

main().catch(console.log);
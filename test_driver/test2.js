const { remote } = require('webdriverio');

async function delay(time) {
  return new Promise(resolve => setTimeout(resolve, time));
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

  const el1 = await driver.$("-android uiautomator:new UiSelector().description(\"Get Started\").instance(1)");
  await el1.click();
  await delay(3000);

  const el2 = await driver.$("-android uiautomator:new UiSelector().className(\"android.widget.Button\").instance(1)");
  await el2.click();
  await delay(3000);

  const el3 = await driver.$("-android uiautomator:new UiSelector().className(\"android.widget.Button\").instance(1)");
  await el3.click();
  await delay(3000);

  const el4 = await driver.$("accessibility id:Scan_Btn");
  await el4.click();
  await delay(3000);

  const el5 = await driver.$("accessibility id:Choose from gallery");
  await el5.click();
  await delay(3000);

  const el6 = await driver.$("-android uiautomator:new UiSelector().resourceId(\"com.android.providers.media.module:id/icon_thumbnail\").instance(10)");
  await el6.click();
  await delay(6000);

  const el7 = await driver.$("accessibility id:Scan bill again");
  await el7.click();
  await delay(3000);

  const el8 = await driver.$("accessibility id:Choose from gallery");
  await el8.click();
  await delay(3000);

  const el9 = await driver.$("-android uiautomator:new UiSelector().resourceId(\"com.android.providers.media.module:id/icon_thumbnail\").instance(6)");
  await el9.click();
  await delay(5000);

  const el10 = await driver.$("accessibility id:Add to transaction");
  await el10.click();
  await delay(6000);

  const el12 = await driver.$("accessibility id:Income");
  await el12.click();
  await delay(3000);

  const el13 = await driver.$("accessibility id:3/4/2018");
  await el13.click();
  await delay(3000);

  const el14 = await driver.$("accessibility id:18, Wednesday, April 18, 2018");
  await el14.click();
  await delay(3000);

  const el15 = await driver.$("accessibility id:OK");
  await el15.click();
  await delay(3000);

  const el16 = await driver.$("-android uiautomator:new UiSelector().className(\"android.widget.ImageView\").instance(3)");
  await el16.click();
  await delay(3000);

  const el17 = await driver.$("-android uiautomator:new UiSelector().resourceId(\"com.android.providers.media.module:id/icon_thumbnail\").instance(11)");
  await el17.click();
  await delay(3000);

  const el18 = await driver.$("accessibility id:Save");
  await el18.click();
  await delay(3000);

  const el19 = await driver.$("accessibility id:Statis_Btn");
  await el19.click();
  await delay(3000);

  const el20 = await driver.$("accessibility id:Income");
  await el20.click();
  await delay(3000);

  await driver.deleteSession();
}

main().catch(console.log);
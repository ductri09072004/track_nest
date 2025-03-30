const { createDriver } = require("./components/appiumConfig");
const { testMyTransactionsScreen } = require("./page/home");
const { testGetStartedScreen } = require("./page/welcome_test");
const { testStatiscalScreen } = require("./page/statiscal_test");

async function main() {
  const driver = await createDriver();

  try {
    //Welcomepage
    await testGetStartedScreen(driver);

    //Home page
    await driver.pause(3000);
    await testMyTransactionsScreen(driver);

    await driver.pause(3000);
    await testStatiscalScreen(driver);
  } catch (error) {
    console.error("❌ Lỗi khi thực hiện test:", error);
  } finally {
    await driver.deleteSession();
  }
}

main();

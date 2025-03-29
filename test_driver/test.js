const { createDriver } = require("./appiumConfig");

// 🔹 Hàm kiểm tra xem có đang ở đúng trang không
async function isCurrentScreen(driver, expectedText) {
  try {
    const element = await driver.$(`android=new UiSelector().description("${expectedText}")`);
    return await element.isDisplayed();
  } catch (error) {
    return false; // Nếu không tìm thấy phần tử => Không ở đúng trang
  }
}

// 🔹 Hàm tìm và click vào button theo content-desc (Semantics Label)
async function testTextClick2(driver, text) {
  console.log(`🔍 Đang tìm button '${text}'...`);

  const element = await driver.$(`android=new UiSelector().description("${text}")`);

  if (await element.isDisplayed()) {
    console.log(`✅ Button '${text}' đã hiển thị!`);
    await element.click();
    console.log(`🖱️ Đã click vào '${text}'!`);
  } else {
    throw new Error(`❌ Button '${text}' không hiển thị!`);
  }
}

// 🔹 Hàm kiểm tra xem text có tồn tại không
async function testTextByContent(driver, text) {
  console.log(`🔍 Đang tìm text '${text}'...`);
  const element = await driver.$(`android=new UiSelector().text("${text}")`);

  if (await element.isDisplayed()) {
    console.log(`✅ Text '${text}' đã hiển thị!`);
  } else {
    throw new Error(`❌ Text '${text}' không hiển thị!`);
  }
}

async function main() {
  const driver = await createDriver();

  try {
    console.log("🔍 Kiểm tra màn hình hiện tại...");

    if (await isCurrentScreen(driver, "Get Started")) {
      console.log("✅ Đang ở màn hình 'Get Started', tiếp tục...");
      await testTextByContent(driver, "Track Your Spending Effortlessly");
      await testTextClick2(driver, "Get Started");
    } else {
      console.error("❌ Không tìm thấy 'Get Started', dừng test.");
      return;
    }

    // Đợi 3 giây để load trang mới
    await driver.pause(3000);

    // Kiểm tra nếu đang ở màn hình "My Transactions"
    if (await isCurrentScreen(driver, "My Transactions")) {
      console.log("✅ Đang ở màn hình 'My Transactions', tiếp tục...");
      await testTextByContent(driver, "Total balance");
      await testTextByContent(driver, "VND");
    } else {
      console.error("❌ Không tìm thấy 'My Transactions', dừng test.");
      return;
    }

  } catch (error) {
    console.error("❌ Lỗi khi thực hiện test:", error);
  } finally {
    await driver.deleteSession();
  }
}

main();

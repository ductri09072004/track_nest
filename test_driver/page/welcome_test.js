const { isCurrentScreen, testTextByContent, testTextClick } = require("../components/help.js");

async function testGetStartedScreen(driver) {
  console.log("🔍 Kiểm tra màn hình 'Get Started'...");

  if (await isCurrentScreen(driver, "Get Started")) {
    console.log("✅ Đang ở màn hình 'Get Started'");
    await testTextByContent(driver, "Track Your Spending Effortlessly");
    await testTextClick(driver, "Get Started");
  } else {
    throw new Error("❌ Không tìm thấy màn hình 'Get Started'");
  }
}

module.exports = { testGetStartedScreen };

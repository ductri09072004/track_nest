const { isCurrentScreen, testTextByContent, testTextClick, testTextNoClick, testScroll } = require("../components/help.js");

async function testStatiscalScreen(driver) {
  console.log("🔍 Kiểm tra màn hình 'Statiscal'...");

  if (await isCurrentScreen(driver, "Statiscal")) {
    console.log("✅ Đang ở màn hình 'Statiscal'");
    
    //balance
    await testTextByContent(driver, "Total balance");
 
  } else {
    throw new Error("❌ Không tìm thấy màn hình 'Statiscal'");
  }
}

module.exports = { testStatiscalScreen };

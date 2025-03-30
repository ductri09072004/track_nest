const { isCurrentScreen, testTextByContent, testTextClick, testTextNoClick, testScroll } = require("../components/help.js");

async function testMyTransactionsScreen(driver) {
  console.log("🔍 Kiểm tra màn hình 'My Transactions'...");

  if (await isCurrentScreen(driver, "My Transactions")) {
    console.log("✅ Đang ở màn hình 'My Transactions'");
    
    //balance
    await testTextByContent(driver, "Total balance");
    await testTextClick(driver, "Toggle_Visibility");
    await testTextByContent(driver, "******");
    await testTextByContent(driver, "Expenses");
    await testTextByContent(driver, "Income");
    await testTextByContent(driver, "VND");

    //body transaction
    await testScroll(driver, "Transactions");
    await testTextNoClick(driver, "ExpenseRow");

    //navigate
    await testTextClick(driver, "Statis_Btn");
  } else {
    throw new Error("❌ Không tìm thấy màn hình 'My Transactions'");
  }
}

module.exports = { testMyTransactionsScreen };

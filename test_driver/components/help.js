// 🔹 Kiểm tra màn hình hiện tại
async function isCurrentScreen(driver, expectedText) {
    try {
      const element = await driver.$(`android=new UiSelector().description("${expectedText}")`);
      return await element.isDisplayed();
    } catch (error) {
      return false;
    }
  }
  
  // 🔹 Click button theo content-desc
  async function testTextClick(driver, text) {
    console.log(`🔍 Tìm button '${text}'...`);
    const element = await driver.$(`android=new UiSelector().description("${text}")`);
    if (await element.isDisplayed()) {
      console.log(`✅ Click '${text}'`);
      await element.click();
    } else {
      throw new Error(`❌ Không tìm thấy '${text}'`);
    }
  }

  async function testTextNoClick(driver, text) {
    console.log(`🔍 Tìm Text '${text}'...`);
    const element = await driver.$(`android=new UiSelector().description("${text}")`);
    if (await element.isDisplayed()) {
      console.log(`✅ Text '${text}' hiển thị`);
    } else {
      throw new Error(`❌ Không tìm thấy '${text}'`);
    }
  }
  
  
  // 🔹 Kiểm tra text có hiển thị không
  async function testTextByContent(driver, text) {
    console.log(`🔍 Tìm text '${text}'...`);
    const element = await driver.$(`android=new UiSelector().text("${text}")`);
    if (await element.isDisplayed()) {
      console.log(`✅ Text '${text}' hiển thị`);
    } else {
      throw new Error(`❌ Text '${text}' không hiển thị`);
    }
  }

  async function testScroll(driver, text) {
    console.log(`🔍 Tìm phần tử '${text}'...`);
    const element = await driver.$(`android=new UiSelector().text("${text}")`);

    if (await element.isDisplayed()) {
        console.log(`✅ Đã tìm thấy '${text}'!`);

        // Lấy vị trí phần tử để làm điểm bắt đầu vuốt
        const location = await element.getLocation();
        const size = await driver.getWindowSize();

        console.log("📌 Vuốt màn hình xuống...");
        
        await driver.performActions([
          {
              type: "pointer",
              id: "finger1",
              parameters: { pointerType: "touch" },
              actions: [
                  // Vuốt lên
                  { type: "pointerMove", duration: 0, x: location.x, y: location.y },
                  { type: "pointerDown" },
                  { type: "pause", duration: 300 }, // Giữ ngón tay một chút
                  { type: "pointerMove", duration: 1000, x: location.x, y: location.y - 800 }, // Vuốt lên
                  { type: "pointerUp" },
                  { type: "pause", duration: 500 }, // Tạm dừng trước khi vuốt tiếp
      
                  // Vuốt xuống
                  { type: "pointerMove", duration: 0, x: location.x, y: location.y - 800 },
                  { type: "pointerDown" },
                  { type: "pause", duration: 300 },
                  { type: "pointerMove", duration: 1000, x: location.x, y: location.y + 800 }, // Vuốt xuống
                  { type: "pointerUp" },
                  { type: "pause", duration: 500 },                 
              ],
          },
      ]);
      

        console.log("✅ Đã vuốt thành công!");
    } else {
        console.log(`❌ Không tìm thấy phần tử '${text}'.`);
    }
}


  
module.exports = { isCurrentScreen, testTextClick, testTextByContent ,testTextNoClick, testScroll};
  
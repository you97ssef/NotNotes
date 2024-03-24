let spreadsheetId = "SPREADSHEET_ID";
let sheetName = "Sheet1";
let code = "YOUR_CODE";

function doGet(request) {
    if (request.parameter.query === "check") {
        return checkCode(request);
    }
    if (request.parameter.code !== code) {
        return ContentService.createTextOutput("Invalid code");
    }
    
    if (request.parameter.query === "all") {
        return allData();
    } else if (request.parameter.query === "save") {
        return saveData(request);
    } else if (request.parameter.query === "delete") {
        return deleteData(request);
    }
}

function checkCode(request) {
    if (request.parameter.code !== code) {
        return ContentService.createTextOutput("Invalid code");
    }

    return ContentService.createTextOutput("Valid code");
}

function allData() {
    let sheet = SpreadsheetApp.openById(spreadsheetId).getSheetByName(sheetName);
    let data = sheet.getDataRange().getValues();
  
    let responseData = [];
    for (let i = 1; i < data.length; i++) {
        let item = {
            id: data[i][0],
            title: data[i][1],
            content: data[i][2],
            createdTime: data[i][3],
            updatedTime: data[i][4]
        };
        responseData.push(item);
    }
    
    return ContentService
        .createTextOutput(JSON.stringify(responseData))
        .setMimeType(ContentService.MimeType.JSON);
}

function saveData(request) {
    let sheet = SpreadsheetApp.openById(spreadsheetId).getSheetByName(sheetName);
    let data = sheet.getDataRange().getValues();
    let isNew = true;

    for (let i = 1; i < data.length; i++) {
        if (data[i][0] == request.parameter.id) {
            isNew = false;

            data[i][1] = request.parameter.title;
            data[i][2] = request.parameter.content;
            data[i][4] = request.parameter.updatedTime;
            sheet.getRange(i + 1, 1, 1, 5).setValues([data[i]]);
            return ContentService.createTextOutput("Data updated successfully");
        }
    }

    if (isNew) {
        let id = request.parameter.id;
        let title = request.parameter.title;
        let content = request.parameter.content;
        let createdTime = request.parameter.createdTime;
        let updatedTime = request.parameter.updatedTime;
        let newData = [id, title, content, createdTime, updatedTime];
        
        sheet.appendRow(newData);
        return ContentService.createTextOutput("Data saved successfully");
    }


    return ContentService.createTextOutput("Data not found");
}

function deleteData(request) {
    let idToDelete = request.parameter.id;
    
    let sheet = SpreadsheetApp.openById(spreadsheetId).getSheetByName(sheetName);
    let data = sheet.getDataRange().getValues();
    
    for (let i = 1; i < data.length; i++) {
        if (data[i][0] == idToDelete) {
            sheet.deleteRow(i + 1);
            return ContentService.createTextOutput("Data deleted successfully");
        }
    }

    return ContentService.createTextOutput("Data not found");
}

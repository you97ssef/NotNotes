# Not notes

An application that allows you to take notes. and can be cloud synced with google sheets. created with flutter using the clean architecture.

## Sync with cloud

- Create a google sheet

- Add the following columns names to the first row of the sheet
    - id
    - title
    - content
    - createdTime
    - updatedTime

- Copy the sheet id from the url of the sheet
    - the link should look like this https://docs.google.com/spreadsheets/d/`SPREADSHEET_ID`/edit?usp=sharing

- Click on Extensions -> Apps Script

- Paste the code from the `Code.gs` file in the editor and change the `SPREADSHEET_ID` variable to the sheet id you copied and `YOUR_CODE` to a secret code that you will use to authenticate the app

- Click on Deploy -> New Deployment

- Select the type as Web App

- In the Configuration section, select the access as Anyone

- Click on Deploy

- Authorize access to the app by using your google account

- When you're done, copy the url of the web app it should look like this https://script.google.com/macros/s/`DEPLOYMENT_ID`/exec

- Now you can use it in the app on the settings page:
    - paste the url of the web app in the Cloud api URL input
    - paste the secret code in the Cloud api Key input

- You're done, now your notes will be synced with the google sheet, enjoy! :)

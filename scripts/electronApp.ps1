Write-Host "to run the script press ENTER" -ForegroundColor Red

pause

New-Item electron-app -ItemType Directory

Set-Location electron-app

npm init -y

npm i electron --save-dev

New-Item main.js

Set-Content main.js "const { app, BrowserWindow, Menu } = require('electron');

const createWindow = () => {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    menu: null, 
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false 
    }
  });

  win.loadFile('index.html');
};

app.whenReady().then(() => {
  createWindow();
  Menu.setApplicationMenu(null); // removes menu bar
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow();
  }
});"

New-Item index.html

Set-Content index.html '<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
</head>
<body>
  <p>hi</p>
</body>
</html>'

Set-Content package.json '{
  "name": "electron-app",
  "version": "1.0.0",
  "main": "main.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "start": "electron ."
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "description": "",
  "devDependencies": {
    "electron": "^29.0.0"
  }
}'

Write-Host "click ENTER to start the app" -ForegroundColor Red

pause

npm start

Write-Host "click ENTER to close terminal" -ForegroundColor Red

pause

Write-Host "to run the script press ENTER" -ForegroundColor Red
pause
mkdir electronApp
cd electronApp
npm init -y
npm i electron --save-dev
ni main.js
sc main.js "const { app, BrowserWindow } = require('electron');

const createWindow = () => {
  const win = new BrowserWindow({
    width: 800,
height: 600,
webPreferences: {
nodeIntegration: true
}
});

  win.loadFile('index.html');
};

app.whenReady().then(createWindow);

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
ni index.html
sc index.html '<!DOCTYPE html>
<html>
<head>
  <meta charset=\"UTF-8\">
  <title>title</title>
</head>
<body>
  <p>hi</p>
</body>
</html>'
sc package.json '{
  "name": "electronApp",
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
    "electron": "^36.2.1"
  }
}'
Write-Host "click enter to start the app" -ForegroundColor Red
pause
npm start
Write-Host "click enter to close terminal" -ForegroundColor Red
pause

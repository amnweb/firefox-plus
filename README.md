# Firefox Plus (Windows only)
> **Note:** FireFox v140+ only

<img src="screenshots/firefox-26-11-2023.jpg" alt="screenshot" title="Screenshot" width="900">
<img src="screenshots/firefox-25-11-2023.jpg" alt="screenshot" title="Screenshot" width="900">
<img src="screenshots/Screenshot 2023-12-04 144143.png" alt="screenshot" title="Screenshot" width="900">

# Rounded Corners
<img src="screenshots/rounded-corners.png" alt="screenshot" title="Screenshot" width="900">

***

# How to install
1. Go to `about:support` and click the "Open Folder/Show in Finder" button for the root directory of your browser profile/s.
2. Download and copy the `chrome` folder and `user.js` into the profile folder.
3. Restart Firefox.

***

# Tweaks
- To enable macOS button style, open `user.js`, find `fp.tweak.macos-button` and set it to `true`.  
- To disable bookmarks autohide open `user.js`, find `fp.tweak.autohide-bookmarks` and set it to `false`.
- To enable or disable rounded corners, open `user.js`, find `fp.tweak.rounded-corners` and set it to `true` or `false`.  
- To enable or disable White Mode, open `user.js`, find `browser.in-content.dark-mode` and set it to `true` or `false`. Then find and set `ui.systemUsesDarkTheme` to `1` or `0`.

***

# Install or update Firefox Plus directly from PowerShell.

1. Open PowerShell.
2. Copy and paste this command

```
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/amnweb/firefox-plus/main/install.ps1'))
```

<img src="screenshots/iex.gif" alt="Preview" title="Preview" width="1244">

***

# 💖 Support & Suggestions

If you enjoy this project and want to help me maintain it further, buying me a coffee would be greatly appreciated! [☕️](https://ko-fi.com/amnweb)

<a href='https://ko-fi.com/amnweb' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://storage.ko-fi.com/cdn/kofi3.png?v=3' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>

***Enjoy your enhanced browsing experience!***

## Star History

![Star History Chart](https://api.star-history.com/svg?repos=amnweb/firefox-plus&type=Date)

# License

This project is licensed under the MIT License.
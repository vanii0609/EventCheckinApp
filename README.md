# Smart Event Check-in & Crowd Management App

Flutter web app for offline-first event setup, participant check-in, dashboard tracking, and searchable logs.

## Run in Chrome

```powershell
Set-Location "d:\MAD\smart_event_checkin_app"
flutter pub get
flutter run -d chrome
```

If Chrome debugging is unavailable, use the web server target:

```powershell
Set-Location "d:\MAD\smart_event_checkin_app"
flutter run -d web-server --web-port=8084
```

Open the app at `http://localhost:8084`.

## Short Notes

Provider is used for simple state management. The app keeps the current event, participants, check-ins, and dashboard counts in one shared `ChangeNotifier`, so every screen can read the same data.

Hive is used for local storage. It saves the event state directly on the device or browser, so the app can reload data even when offline.

Offline-first means the app is designed to work without internet first, and sync later if needed. In this project, data is stored locally and a dummy sync button is used to simulate syncing.

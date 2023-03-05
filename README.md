# save_location

Build demo app with requirements:
- Using background service for tracking user location in foreground, background and saved it into local
  + With kill app mode: currently, flutter doesn't support that. When the app is killed (not the same as put in the background) the instance of the app is removed thus it wont be able to run the package to fetch the location.
- Display all local location saved into List View
Demo app with:
- Manage state: Provider
- Pattern: MVVM
- Save DB local: sqflite
- Run app in background: workmanager
- Get location: geolocator

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

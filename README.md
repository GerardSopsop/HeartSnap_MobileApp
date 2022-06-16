# HeartSnap Mobile App

## App Description

HeartSnap is a diary mobile application for daily eaten food and their corresponding nutriments. HeartSnap uses three input methods: using image recognition to determine the name and nutrient-content from an image of the food, barcodes from commercial products, and manual input of the name of the food. It will return a list of values for specific nutrient infos. HeartSnap will store this data and show the user whether they are eating healthy or not.

## App Specifications

```bash
Programming Language: DART
Platforms: Android, iOS
```

## Required Installations

```bash
# Download android studio and install all necessary SDK Tools and Platforms
https://developer.android.com/studio

# Download a programming editor, preferrably VS Code 
https://code.visualstudio.com/

# Download necessarary extensions in the VS Code
1. DART
2. Flutter  
3. Prettier (For better coding experience)
```

## Running and debugging the app

```bash
# Go to project directory
$ cd <directory>

# Choose a virtual device
Choose from windows, chrome, or a connected mobile device

# Run the app
$ flutter run
```

## Building the APK

```bash
# Generate fat APK for general mobile specifications
$ flutter build apk

# Generate three APKs for specific mobile specifications
$ flutter build apk --split-per-abi
```

## Installing the fat APK

```bash
# Go to the release folder within the project directory
C:\Users\user\ProjectDirectory\build\app\outputs\apk\release

#Look for an APK file
"app-release.apk"`

#Copy this file to your device and click it to install
```

## License

Flutter is under "New BSD License"
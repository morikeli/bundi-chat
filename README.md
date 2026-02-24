# Bundi Chat

## Mobile app screenshots
| Home screen | Onboarding screen |
| ------------------------- | ------------------------- |
| | |

## Overview
Bundi chat is a simple chat app that works on Android and iOS. Users can send and share messages to each other.

### Key features


### Tech Stack
- 🎨 **Frontend**: Flutter v3.38.5, Dart v3.10.4
- ☁️ **Backend & Auth**: Supabase
- 💾 **Storage**: PostgreSQL
- ⚡ **State Management**: BLoC
- 🏗️ **Architecture**: MVVM (separation of logic, UI, and services)
- 🗃️ **Libraries/packages**:
    - *toastification* - display toast notifications in the app
    - *flutter_native_splash* - for creating and generating app splash screen
    - *flutter_launcher_icons* - for creating and generating launcher icons
    - *uuid* - for generating UUID for id fields in Firebase collections
    - *intl* - for applying date and number formats
    - *adaptive_theme* - for changing app theme
    - *bubble* - for chat bubbles



## Developer instructions
---
> [!WARNING]
> To run this project, you **MUST** install Flutter SDK on your machine. Refer to [Flutter's documentation](https://docs.flutter.dev/get-started/install) and follow a step-by-step guide on how you can install Flutter SDK on your OS.
>
> Make sure you have installed Android Studio or a text editor of your choice - VS Code or XCode.
>
> Make sure your machine supports virtualization - required to run an emulator. If it doesn't, don't worry, you can install `scrcpy` on your machine or use Android Studio's `mirror device` feature.

**Scrcpy Installation guide** 
* [Install scrcpy on Windows](https://github.com/Genymobile/scrcpy/blob/master/doc/windows.md)
* [Install scrcpy on Linux](https://github.com/Genymobile/scrcpy/blob/master/doc/linux.md)
* [Install scrcpy on MacOS](https://github.com/Genymobile/scrcpy/blob/master/doc/macos.md)

---

#### Installation guide for developers

1. Git clone

Clone this repository by opening your terminal/CMD and change the current working directory to Desktop - use `cd Desktop` command.
```bash
    cd Desktop
    git clone https://github.com/morikeli/bundi-chat.git
```

2. Open the cloned repository on your text editor and run this command:
```bash
    cd bundi-chat  # or change dir in the terminal and run the `flutter run` command
    flutter run
```
3. Make sure you have a very strong internet connection so that the necessary gradle files can be downloaded. These files are necessary to build the project `apk` file.

---
> [!NOTE]
>
> When building the application for the first time, it may take 10 - 15 minutes to finish the installation and build process.
> When running the application using the `flutter run` command, it may take atleast a minute to install the build files on a physical device.
---


## 🤝 Contributor expectations
Incase of a bug or you wish to make a contribution, create a new branch using the git command `git checkout -b <name of your branch>` and create a pull request. Wait for review.

You can also open an issue using the `Issues` tab. The reported issue will be reviewed and a solution may be provided.


## 🙏 Request
Don't forget to star the repo 🌟😉

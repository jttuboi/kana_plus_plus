# KWriting

## About the app

The app is intended to teach beginners to learn Japanese Hiragana and Katakana alphabets through writing. For this, a technique was used that uses words (usually the names of things) to learn how to write in Japanese.

The use of images of things was also used to directly associate what the user is writing in Japanese with the visual representation, thus avoiding directly associating the translated word. That's why words like adjectives, actions, verbs are not used, as they are more difficult to represent visually by a static image.

As an extra, the learner will gain an initial vocabulary.

For more information, access the app on the Play Store:
https://play.google.com/store/apps/details?id=com.kana_plus_plus

## Printscreen

<table>
<tr style="border: none;">
<td style="border: none;">
<img src="/github/1.jpg" width="241" height="512" />
<img src="/github/3.jpg" width="241" height="512" />
<img src="/github/4.jpg" width="241" height="512" />
</td>
</tr>
<tr style="border: none;">
<td style="border: none;">
<img src="/github/2.jpg" width="241" height="512" />
<img src="/github/5.jpg" width="241" height="512" />
<img src="/github/6.jpg" width="241" height="512" />
</td>
</tr>
</tr>
<tr style="border: none;">
<td style="border: none;">
<img src="/github/7.jpg" width="241" height="512" />
<img src="/github/8.jpg" width="241" height="512" />
</td>
</tr>
</table>

### Name changed

The project was originally called Kana++, but due to Play Store developer policy, repeated special characters are not accepted. Therefore, the app is called KWriting. <i>No creativity moment when creating this name</i> :neutral_face:.

## About the project

This app was built in order to apply the techniques learned about Flutter and also about software architecture. In addition, the application was sent to the Play Store in order to learn the entire process from creating the idea to sending the app to the Play Store.

The project was built with `Flutter 2.5.3` and `Dart 2.14.4` with focus on Android (it wasn't implemented for iOS, but is pre-prepared to include code to deploy for iOS).

To build the app, we used VSCode, Inkscape (images), python (automatic manipulation of .svg data to generate points) and flutter coverage (chocolatey + lcov + perl).

If you want to follow the next steps of the project, go to GitHub: https://github.com/jttboi/kana_plus_plus/issues

## Understanding Project Architecture

#### **Domain layer**
**models:** contains entities of the app.
**repositories:** contains repositories interface.
**services:** contains services interface.
**utils:** contains constants used in the app.

#### **Infra layer**
**datasources:** contains bridge to access database and file.
**repositories:** contains repositories implementation.
**services:** contains services implementation.

#### **Presentation layer**
***feature_folder*:** it is the folder of feature of the app.
**shared:** it is the folder of shared data used in any part of the presentation layer.

**bloc/cubit:** contains files of state management of BloC pattern.
**notifiers:** contains files of state management of Change notifier + Provider.
**controllers:** contains files of old controller of MVC pattern.
**enums/view_models:** contains enums and view models used in presentation layer.
**pages:** contains pages of screen app.
**widgets:** contains widgets to used in any part of page.

#### **Other files**
**test/:** contains tests of the app.
**l10n/:** contains texts for internationalization.
**analysis_options.yaml:** it is the configuration file of the Lint.
**l10n.yaml:** it is the configuration file of the Internationalization.
**pubspec.yaml:** it is the configuration file of Flutter project.

## Extra instructions

### Project execution

- Git clone or download the project.

- After getting the project, enter the project folder from the terminal and type `flutter pub get` to get the packages and update the project.

- Don't forget to change the `android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"` content in the `android/app/src/main/AndroidManifest.xml` file.
If not, the project will not deploy to mobile/emulator.
This value is the app ID generated on the adMob website. For more information, go to:
https://flutter.dev/ads
https://pub.dev/packages/google_mobile_ads

- Then use `flutter build apk` command to generate the apk.
I recommend using VSCode or Android Studio to run the project. With some of them it's easier to create Android emulators or have access to DevTools for better debugging.

### Update app icon

To update the app icon, the package [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) is used.

#### Android

First you need to create 3 pngs:
- `assets/icons/app_icon_background.png`
- `assets/icons/app_icon_foreground.png`
- `assets/icons/app_icon.png`

After that, run in the terminal:
```sh
flutter pub run flutter_launcher_icons:main
```

The package will automatically generate the necessary images inside the android folder.

More information at: [Android Adaptive Icon](https://developer.android.com/guide/practices/ui_guidelines/icon_design_adaptive)

Extra: if you want to modify the splash screen that is shown when opening the app, modify the file `android/app/src/main/res/drawable/launch_background.xml`.

More information at: [Splash Screen Flutter](https://flutter.dev/docs/development/ui/advanced/splash-screen)

#### iOS

To update the app icon for iOS, you need to uncomment in `pubspec.yaml` the line `ios: true`.

Note: Read [Note](https://pub.dev/packages/flutter_launcher_icons#mag-attributes) to see how to apply the app icon design on iOS.

After that, run in the terminal:
```sh
flutter pub run flutter_launcher_icons:main
```

### Using flutter coverage on Windows

- Install the [chocolatey](https://chocolatey.org/install).
Don't recommended to install as administrator, because it will need permissions to use chocolatey every time.

- Isntall the [lcov](https://community.chocolatey.org/packages/lcov#individual).

- Install the [perl](https://www.perl.org/get.html).
If it is not on PATH, add the `C:/PERL_PATH/perl.exe` in User variables and System variables. You can find the perl folder on C:/.

- after installation, go to project folder on CMD and execute the coverage.

``` sh
flutter test --coverage ./lib
```

- after, use the command perl to generate html.

``` sh
perl C:\CHOCOLATEY_PATH\chocolatey\lib\lcov\tools\bin\genhtml -o coverage C:\FLUTTER_PROJECT_PATH\coverage\lcov.info
```

- open the index.html file with the favorite browser and it will show the coverage of the project.

## License

##### License copied from terms of use

The software is open source. Its code is shared at https://github.com/jttuboi/kana_plus_plus. All content specifically available in the repository can be used under the MIT License.

The images used as the images of the words and the images of the hiraganas and katakanas are my property. They are not allowed to be used, modified or shared in other projects without my permission. That's why it's not even shared in the project.

The image strokes of the hiragana and katakana syllables were taken from [KanjiVG](http://kanjivg.tagaini.net/) and these images are on [Creative Commons Attribution-Share Alike 3.0](https://creativecommons.org/licenses/by-sa/3.0/) license.

The syllable points were taken from the SVG images of [KanjiVG](http://kanjivg.tagaini.net/) and these images are over [Creative Commons Attribution-Share Alike 3.0](https://creativecommons.org/licenses/by-sa/3.0/) license.

The overview information is taken from Wikipedia [Hiragana en](https://en.wikipedia.org/wiki/Hiragana), [Hiragana pt](https://pt.wikipedia.org/wiki/Hiragana) [Katakana en](https://en.wikipedia.org/wiki/Katakana), [Katakana pt](https://pt.wikipedia.org/wiki/Katakana).

The licenses for the fonts used are mentioned within the project and can be seen at https://github.com/jttuboi/kana_plus_plus/tree/master/assets/fonts.

The icons were taken from [Google fonts](https://fonts.google.com/icons) and those non-existent icons were created by me and can be seen at https://github.com/jttuboi/kana_plus_plus/tree/master/assets/icons.

The word data information were mostly collected through [Jisho](https://jisho.org/).

##### Terms of use and privacy policy

https://tuboi-studios.github.io/kwriting_terms_of_use_and_privacy_policy/

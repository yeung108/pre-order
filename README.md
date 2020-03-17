## About
This is the Sample Pre-Ordering App for restaurants using BLoC Pattern 

## Building and Running

See [the main project README](../README.md).

To build without running, use `flutter build macos`/`windows`/`linux` rather than `flutter run`, as with
a standard Flutter project.

## Dart Differences from Flutter Template

The `main.dart` and `pubspec.yaml` have minor changes to support desktop:
* `debugDefaultTargetPlatformOverride` is set to avoid 'Unknown platform'
  exceptions.
* The font is explicitly set to Roboto, and Roboto is bundled via
  `pubspec.yaml`, to ensure that text displays on all platforms.

See the [Flutter Application Requirements section of the Flutter page on
desktop support](https://github.com/flutter/flutter/wiki/Desktop-shells#flutter-application-requirements)
for more information.

### Coping the Desktop Runners

The 'linux' and 'windows' directories are self-contained, and can be copied to
an existing Flutter project, enabling `flutter run` for those platforms.

**Be aware that neither the API surface of the Flutter desktop libraries nor the
interaction between the `flutter` tool and the platform directories is stable,
and no attempt will be made to provide supported migration paths as things
change.** You should expect that every time you update Flutter you may have
to delete your copies of the platform directories and re-copy them from an
updated version of flutter-desktop-embedding.

![](demo/demo.gif)
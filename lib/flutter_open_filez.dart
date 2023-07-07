// ignore_for_file: no_runtimetype_tostring

import 'dart:io';

import 'package:dart_extensionz/dart_extensionz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_open_filez/flutter_open_filez_platform_interface.dart';
import 'package:path_provider/path_provider.dart';

/// The entry point for [FlutterOpenFilez].
class FlutterOpenFilez {
  Future<void> open(
    String path, {
    String? type,
  }) async {
    if (path.isEmpty) {
      throw PathEmptyException();
    }

    final File file = File(path);

    if (!file.existsSync()) {
      throw FileNotFoundException();
    }

    // copy this file to a cache directory
    // this is to remove the need for dir/permission checking on any platform
    final Directory cacheDir = await getTemporaryDirectory();
    final File newFile = file.copySync('${cacheDir.path}/${file.name}');

    final Map<String, String?> params = <String, String?>{
      'path': newFile.path,
      'type': type ?? newFile.mimeType,
    };

    try {
      return FlutterOpenFilezPlatform.instance
          .open(params)
          // this dosent seem to do what i'm asking of it....
          .whenComplete(newFile.deleteSync);
    } on PlatformException catch (e) {
      throw FlutterOpenFilezException(e.message);
    }
  }
}

/// A custom exception to format our errors.
class FlutterOpenFilezException implements Exception {
  FlutterOpenFilezException([this.message]);

  final String? message;

  @override
  String toString() {
    final String? message = this.message;
    if (message == null || message.isEmpty) {
      return '$runtimeType: An unknown error occurred.';
    }
    return message;
  }
}

class PathEmptyException extends FlutterOpenFilezException {
  PathEmptyException([super.message = 'The path must not be empty.']);
}

class FileNotFoundException extends FlutterOpenFilezException {
  FileNotFoundException([super.message = 'The file does not exist.']);
}

// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "app_title": "Paperless",
    "auth": {
      "title": "Add Paperless account",
      "error": {
        "server_unreachable": {
          "title": "Server unreachable",
          "description":
              "The server is unreachable, make sure you have internet connection and the server url is correct"
        }
      },
      "server": {
        "label": "Server",
        "placeholder": "Enter your server url",
        "description": "This is your paperless server url",
        "error": {"required": "Server url is required"}
      },
      "username": {
        "label": "Username",
        "placeholder": "Enter your username",
        "description": "This is your paperless account email",
        "error": {"required": "Username is required"}
      },
      "password": {
        "label": "Password",
        "placeholder": "Enter your password",
        "description": "This is your paperless account password",
        "error": {"required": "Password is required"}
      },
      "action": {
        "sign_in": "Sign in",
        "validate": "Continue",
        "sign_up": "Sign up",
        "forgot_password": "Forgot password?"
      }
    }
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {"en": en};
}

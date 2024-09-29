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
      "server": {
        "label": "Server",
        "placeholder": "Enter your paperless server url",
        "description": "This is your paperless server url",
        "error": {
          "required": "Server url is required",
          "invalid": "Invalid server url"
        }
      },
      "email": {
        "label": "Email",
        "placeholder": "Enter your email",
        "description": "This is your paperless account email",
        "error": {"required": "Email is required", "invalid": "Invalid email"}
      },
      "password": {
        "label": "Password",
        "placeholder": "Enter your password",
        "description": "This is your paperless account password"
      },
      "action": {
        "sign_in": "Sign in",
        "sign_up": "Sign up",
        "forgot_password": "Forgot password?"
      }
    }
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {"en": en};
}

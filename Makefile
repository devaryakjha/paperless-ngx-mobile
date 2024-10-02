gen-once:
	dart run build_runner build --delete-conflicting-outputs

gen-watch:
	dart run build_runner watch --delete-conflicting-outputs

gen-tr:
	dart run easy_localization:generate --source-dir ./assets/translations --output-dir ./lib/core/translations --output-file loader.dart
	dart format ./lib/core/translations/loader.dart
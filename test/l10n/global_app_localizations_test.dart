import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_stats_app/l10n/global_app_localizations.dart';

void main() {
  group('current', () {
    test('returns AppLocalizations instance properly', () {
      final globalAppLocalizations = GlobalAppLocalizationsImpl();

      final appLocalizations = AppLocalizationsEn();

      globalAppLocalizations.setAppLocalizations(appLocalizations);

      expect(globalAppLocalizations.current, isA<AppLocalizations>());
      expect(globalAppLocalizations.current, isA<AppLocalizationsEn>());
      expect(globalAppLocalizations.current.appName, 'Github Stats');
      expect(globalAppLocalizations.current.localeName, 'en');
    });

    test('throws an Exception when AppLocalizations has not been set', () {
      final globalAppLocalizations = GlobalAppLocalizationsImpl();

      expect(() => globalAppLocalizations.current, throwsA(isA<Exception>()));
    });
  });
}

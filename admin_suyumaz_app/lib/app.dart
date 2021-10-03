import 'package:admin_suyumaz_app/utils/constants/navigator_keys.dart';
import 'package:admin_suyumaz_app/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'localization/app_localization.dart';
import 'localization/localization_constants.dart';
import 'routes/routes.dart';
import 'utils/themes/theme.dart';

class MyApp extends StatelessWidget {
  Map<String, dynamic> localizedValues;
  String language;
  String _locale = 'en';
  final uniqueKey = UniqueKey();
  MyApp(this.localizedValues,this.language);

  @override
  Widget build(BuildContext context) {
    if (language != null) {
      _locale = language;
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        )
      ],
      child: MaterialApp(
        key: uniqueKey,
        title: 'SuyumAz',
        debugShowCheckedModeBanner: false,
        theme: Themes.defaultTheme,
        initialRoute: SetupRoutes.initialRoute,
        navigatorKey: NavigationKeys.globalNavigatorKey,
        routes: SetupRoutes.routes,
        locale: Locale(_locale),
        localizationsDelegates: [
          AppLocalizationsDelegate(localizedValues),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: LocalizationConstants.languages
            .map((language) => Locale(language, '')),
      ),
    );
  }
}

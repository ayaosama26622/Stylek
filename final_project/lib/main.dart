import 'dart:async';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:final_project/core/services/local/shared_pref.dart';
import 'package:final_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:final_project/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await SharedPref.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  unawaited(FirebaseProvider.seedDefaultProductsIfNeeded().catchError((_) {}));

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: const MainApp(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:task_managing/presentation/views/login_signup_screen.dart';

import 'config/builders/app_builder.dart';
import 'config/providers/bloc_providers.dart';
import 'config/router/router.dart';
import 'config/themes/app_themes.dart';
import 'locator.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: getProviders(context, locator),
      child: OKToast(
        child: MaterialApp(
          title: 'Tour',
          theme: AppTheme.light,
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginSignUpScreen(),
            //'/': (context) => EventsToursSearchScreen(),
          },
          onGenerateRoute: (settings) => GeneratedRoutes(settings, context),
          builder: smartDialogBuilder(),
        ),
      ),
    );
  }
}
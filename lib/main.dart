import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:opporto_project/core/services/shared_prefs.dart';
import 'package:opporto_project/featuers/application/data/repo/app_repo_impl.dart';
import 'package:opporto_project/featuers/application/data/sources/ds.dart';
import 'package:opporto_project/featuers/application/domain/use_cases/app_ues_case.dart';
import 'package:opporto_project/featuers/application/presentation/manager/applcation_bloc.dart';
import 'package:opporto_project/featuers/login/login_view.dart';
import 'package:opporto_project/featuers/notifications_screen/data/repo/notification_repo_impl.dart';
import 'package:opporto_project/featuers/notifications_screen/data/source/notification_ds.dart';
import 'package:opporto_project/featuers/notifications_screen/domain/use_case/all_read_use_case.dart';
import 'package:opporto_project/featuers/notifications_screen/domain/use_case/get_notifications_useCase.dart';
import 'package:opporto_project/featuers/notifications_screen/domain/use_case/notification_read_use_case.dart';
import 'package:opporto_project/featuers/notifications_screen/presentation/manager/notification_bloc.dart';
import 'package:opporto_project/featuers/notifications_screen/presentation/manager/notification_event.dart';

import 'package:provider/provider.dart';

import 'package:opporto_project/core/ui/splash.dart';
import 'package:opporto_project/core/provider/provider_language.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/core/provider/user_roles_provider.dart';


import 'core/provider/jop_provider.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs.init();

  await dotenv.load();
  final dio = Dio();



  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserRolesProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => JobsProvider()),
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),

        BlocProvider(
          create: (context) {

            final notificationDs = NotificationDataSourceImpl(dio);


            final notificationRepo = NotificationRepositoryImpl(notificationDs);


            final getNotificationsUseCase = GetMyNotificationsUseCase(notificationRepo);
            final readUseCase = NotificationReadUseCase(notificationRepo);
            final allReadUseCase = AllReadUseCase(notificationRepo);


            return NotificationBloc(
              getNotificationsUseCase: getNotificationsUseCase,
              readUseCase: readUseCase,
              allReadUseCase: allReadUseCase,
            )..add(GetNotificationsEvent(
                token: Provider.of<UserProvider>(context, listen: false).token ?? ""
            ));
          },
        ),
        BlocProvider(
          create: (context) {
            final applicationDs = ApplicationRemoteDataSource(dio);
            final applicationRepo = ApplicationRepository(applicationDs);
            final postApplicationUseCase = PostApplicationUseCase(applicationRepo);
            return ApplicationBloc(postApplicationUseCase);
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<AppLanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: languageProvider.appLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,


      home: Splash(),
    );
  }
}
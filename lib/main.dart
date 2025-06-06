import 'package:crm/config/DB/object_box_connection.dart';
import 'package:crm/config/DI/dependencias.dart';
import 'package:crm/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ObjectBoxConnection objectBox = await ObjectBoxConnection.create();

  runApp(
    ProviderScope(
      overrides: [objectBoxProvider.overrideWithValue(objectBox)],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(ariculoOBXImplProvider).cargarArticulos();
    return ScreenUtilInit(
        designSize: Size(430, 930),
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
            ],
            theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)),
            routerConfig: ref.watch(routerProvider),
          );
        }
    );
  }
}


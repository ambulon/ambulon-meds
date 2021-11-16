import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medcomp/views/splash_screen.dart';
import 'bloc/main.bloc.dart';

class Version {
  static String code = "1.1.3";
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MainBloc.allBlocs(),
      child: MaterialApp(
        title: 'Ambulon',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.teal[900],
          textTheme: GoogleFonts.openSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: SplashScreen(),
        // home: TempParent(),
      ),
    );
  }
}

import 'models/user_model.dart';
import 'route_generator.dart';
import 'screens/firebase_not_initialize.dart';
import 'screens/splash.dart';
import 'services/auth_service.dart';
import 'services/user_service.dart';
import 'wrapper.dart';
import 'wrapper_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initilization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors and show screen accordingly
        if (snapshot.hasError) return FirebaseNotInitialize();

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) return MyApp();

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(home: Splash());
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<AuthService>(create: (_) => AuthService())],
      child: WrapperBuilder(builder: (context, userSnapshot) {
        return MaterialAppWrapper(userSnapshot: userSnapshot);
      }),
    );
  }
}

class MaterialAppWrapper extends StatelessWidget {
  final AsyncSnapshot<FBUser> userSnapshot;
  MaterialAppWrapper({this.userSnapshot});

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      if (userSnapshot.hasData) {
        final userService = Provider.of<UserService>(context);

        return MultiProvider(
            providers: [
              StreamProvider<MyUser>.value(value: userService.streamUser),
            ],
            child: MaterialApp(
                // title: AppConfig.of(context).appTitle,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: RouteGenerator.generateRoute,
                home: Wrapper(userSnapshot: userSnapshot)));
      }
    }
    return MaterialApp(
        // title: AppConfig.of(context).appTitle,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: Wrapper(userSnapshot: userSnapshot));
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'screens/auth_gate.dart';
import 'services/auth_service.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const TcfcApp());
}

class TcfcApp extends StatelessWidget {
  const TcfcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthService()),
        ),
      ],
      child: MaterialApp(
        title: 'TCFC VA',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const AuthGate(),
      ),
    );
  }
}

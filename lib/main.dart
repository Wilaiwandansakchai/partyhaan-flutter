import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partyhaan/repositories/auth_repository.dart';
import 'package:partyhaan/screen/app/view/app.dart';
import 'app/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp();
  final AuthRepository authRepository = AuthRepository();

  runApp(App(authRepository: authRepository));
}

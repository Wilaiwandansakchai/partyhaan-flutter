import 'package:flutter/widgets.dart';
import 'package:partyhaan/screen/home/home_screen.dart';
import 'package:partyhaan/screen/login/login_screen.dart';

import '../../blocs/app/app_bloc.dart';


List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}

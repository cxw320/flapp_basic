//Navigation routes are defined in the below GoRouter configuration

import 'package:flap_basic/data/repository/auth/auth_repository_impl.dart';
import 'package:flap_basic/data/repository/secure_storage/secure_storage_impl.dart';
import 'package:flap_basic/domain/entity/event.dart';
import 'package:flap_basic/domain/usecase/log_in_usecase_impl.dart';
import 'package:flap_basic/modules/home_screen/home_screen_view.dart';
import 'package:flap_basic/modules/login_screen/login_screen_state.dart';
import 'package:flap_basic/modules/login_screen/login_screen_view.dart';
import 'package:flap_basic/modules/login_screen/login_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter navigationRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        final authRepo = AuthRepositoryImpl();
        final logInUseCase = LogInUseCaseImpl(authRepository: authRepo);
        final storageService = SecureStorageImpl();
        final loginScreenViewModel = LoginScreenViewModel(
            logInUseCase: logInUseCase,
            storageService: storageService);
        return LoginScreen(viewModel: loginScreenViewModel);
      },
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
  ],
);

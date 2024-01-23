import 'package:flap_basic/domain/entity/event.dart';
import 'package:flap_basic/domain/entity/login_error.dart';
import 'package:flap_basic/domain/entity/login_info.dart';
import 'package:flap_basic/domain/entity/request_response.dart';
import 'package:flap_basic/domain/entity/storage_error.dart';
import 'package:flap_basic/domain/entity/user_info.dart';
import 'package:flap_basic/domain/repository/secure_storage/secure_storage.dart';
import 'package:flap_basic/domain/usecase/log_in_usecase.dart';
import 'package:flap_basic/modules/login_screen/login_screen_state.dart';
import 'package:flutter/material.dart';

class LoginScreenViewModel {
  LoginScreenViewModel(
      {required this.logInUseCase,
      required this.storageService});

  final ValueNotifier<LoginScreenState> state =
      ValueNotifier<LoginScreenState>(LoginScreenState.initial());
  LogInUseCase logInUseCase;
  StorageService storageService;

  void login(String email, String password) async {
    if (state.value.loginEvent is LoadingEvent) {
      return;
    }

    state.value = LoginScreenState.loading();

    final response = await logInUseCase.logIn(
      LoginInformation(
        email: email,
        password: password,
      ),
    );

    switch (response) {
      case SuccessRequestResponse<UserInfo, LoginError>():
        final jwtSaveSuccessful = await _saveJwt(response.data.jwtToken);

        if (jwtSaveSuccessful) {
          state.value = LoginScreenState.success(response.data);
        } else {
          state.value = LoginScreenState.error(LoginError.jwtSaveUnsuccessful);
        }
      case ErrorRequestResponse<UserInfo, LoginError>():
        state.value = LoginScreenState.error(response.error);
    }
  }

  Future<bool> _saveJwt(String token) async {
    final saveToken = await storageService.writeJwt(token);

    return saveToken is SuccessRequestResponse<String, StorageError>;
  }
}

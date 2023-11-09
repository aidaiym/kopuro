import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/app/services/auth_service.dart';
import 'package:kopuro/models/user/user_model.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.service) : super(AuthState(user: service.init));

  final AuthService service;

  Future<AuthState> login(String languageCode, String userType) async {
    final user = await service.login(languageCode, userType);
    user.fold(
      (l) => emit(state.copyWith(exception: l)),
      (r) => emit(state.copyWith(user: r)),
    );
    return state;
  }
}

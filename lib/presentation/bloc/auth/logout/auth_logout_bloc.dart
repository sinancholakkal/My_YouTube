import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_logout_event.dart';
part 'auth_logout_state.dart';

class AuthLogoutBloc extends Bloc<AuthLogoutEvent, AuthLogoutState> {
  AuthLogoutBloc() : super(AuthLogoutInitial()) {
    on<AuthLogoutEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

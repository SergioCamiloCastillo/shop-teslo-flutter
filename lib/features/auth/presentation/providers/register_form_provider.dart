//1. Crear el estado de este provider como StateNotifierProvider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop_flutter/features/shared/shared.dart';

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Name name;
  final Password password;
  final PasswordRepeat passwordRepeat;

  RegisterFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.name = const Name.pure(),
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.passwordRepeat = const PasswordRepeat.pure()});

  RegisterFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          Email? email,
          Name? name,
          Password? password,
          PasswordRepeat? passwordRepeat}) =>
      RegisterFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          email: email ?? this.email,
          name: name ?? this.name,
          password: password ?? this.password,
          passwordRepeat: passwordRepeat ?? this.passwordRepeat);
  @override
  String toString() {
    return '''
    Register form state:
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      email: $email
      name: $name
    ''';
  }
}

//2. Como implementamos un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallback;
  //en el super mandamos la creacion del estado inicial o pure(), que es cuando no se ha tocado el formulario
  RegisterFormNotifier({required this.registerUserCallback})
      : super(RegisterFormState());
  onEmailChange(String value) {
    // .dirty indica que el campo de correo electrónico ha sido modificado y necesita validación.
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate(
            [newEmail, state.password, state.passwordRepeat, state.name]));
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate(
            [newPassword, state.email, state.passwordRepeat, state.name]));
  }

  onPasswordRepeatChange(String value) {
    final newPasswordRepeat = PasswordRepeat.dirty(value);
    state = state.copyWith(
        passwordRepeat: newPasswordRepeat,
        isValid: Formz.validate(
            [newPasswordRepeat, state.email, state.password, state.name]));
  }

  onNameChange(String value) {
    final newName = Name.dirty(value);
    print("llega aqui");
    state = state.copyWith(
        name: newName,
        isValid: Formz.validate(
            [newName, state.email, state.password, state.passwordRepeat]));
  }

  onFormSubmit() async {
    _touchedEveryField();
    if (!state.isValid) return;
    await registerUserCallback(
        state.email.value, state.password.value, state.name.value);
  }

  _touchedEveryField() {
    //verificar todos los campos para saber si hay error
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final name = Name.dirty(state.name.value);
    final passwordRepeat = PasswordRepeat.dirty(state.passwordRepeat.value);
    // cuando hago asignacion del state como state=, le estoy diciendo a flutter que hubo un cambio en el state, manda a verficar a todos los listener que esten pendiente de los cambios de estado
    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        name: name,
        passwordRepeat: passwordRepeat,
        isValid: Formz.validate([email, password, passwordRepeat, name]));
  }
}

//3. Como consumir el provider, lo que se consume afuera
final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  //autodispose destruye informacion cuando se cambie de pantalla
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});

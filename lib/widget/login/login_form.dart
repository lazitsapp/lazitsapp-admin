import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_admin/bloc/auth/auth_bloc.dart';
import 'package:lazitsapp_admin/router/router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool readOnly = false;
  final _formKey = GlobalKey<FormBuilderState>();

  void onLogin() {
    FormBuilderState? formState = _formKey.currentState;

    if (formState != null && formState.saveAndValidate()) {

      Map<String, dynamic>? values = formState.value;

      String email = values['email'] as String;
      String password = values['password'] as String;

      BlocProvider.of<AuthBloc>(context).add(
        SigninWithEmailAndPassword(email, password)
      );
    } else {
      debugPrint('validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prevState, nextState) {
        return (
          prevState.authStatus != AuthStatus.signedIn &&
          nextState.authStatus == AuthStatus.signedIn
        );
      },
      listener: (context, state) {
        GoRouter.of(context).go(AppPage.home.path);
      },
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 521),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Login', style: Theme
                  .of(context)
                  .textTheme
                  .headlineSmall),

              const SizedBox(height: 15),

              Theme(
                data: ThemeData.light(),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: FormBuilder(
                    key: _formKey,
                    // enabled: false,
                    autovalidateMode: AutovalidateMode.disabled,
                    skipDisabled: true,
                    child: Column(
                      children: <Widget>[

                        FormBuilderTextField(
                          name: 'email',
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),

                        FormBuilderTextField(
                          name: 'password',
                          decoration: const InputDecoration(
                              labelText: 'Password'),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),

                        const SizedBox(height: 16),

                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                onPressed: onLogin,
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


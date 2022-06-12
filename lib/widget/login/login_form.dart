import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_admin/bloc/auth/auth_bloc.dart';
import 'package:lazitsapp_admin/router/router_utils.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool readOnly = false;
  final _formKey = GlobalKey<FormBuilderState>();

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 521),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Login', style: Theme.of(context).textTheme.headlineSmall),
          FormBuilder(
            key: _formKey,
            // enabled: false,
            // onChanged: () {
            //   _formKey.currentState!.save();
            //   debugPrint(_formKey.currentState!.value.toString());
            // },
            autovalidateMode: AutovalidateMode.disabled,
            // initialValue: const {
            //   'movie_rating': 5,
            //   'best_language': 'Dart',
            //   'age': '13',
            //   'gender': 'Male'
            // },
            skipDisabled: true,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.always,
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (val) {
                    // setState(() {
                    //   _ageHasError = !(_formKey.currentState?.fields['age']
                    //       ?.validate() ??
                    //       false);
                    // });
                  },
                  // valueTransformer: (text) => num.tryParse(text),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                  // initialValue: '12',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.always,
                  name: 'password',
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  onChanged: (val) {
                    setState(() {
                      // _ageHasError = !(_formKey.currentState?.fields['age']
                      //     ?.validate() ??
                      //     false);
                    });
                  },
                  // valueTransformer: (text) => num.tryParse(text),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  // initialValue: '12',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {

                      Map<String, dynamic>? values =
                        _formKey.currentState?.value;

                      String email = values!['email'] as String;
                      String password = values['password'] as String;

                      BlocProvider.of<AuthBloc>(context).add(
                        SigninWithEmailAndPassword(
                          email,
                          password,
                          () => GoRouter.of(context).goNamed(AppPage.home.toName)
                        )
                      );

                    } else {
                      debugPrint(_formKey.currentState?.value.toString());
                      debugPrint('validation failed');
                    }
                  },
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
    );
  }
}


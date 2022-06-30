import 'dart:typed_data';
import 'package:author_repository/author_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lazitsapp_admin/widget/util/util.dart';

import '../../bloc/author/author_bloc.dart';
import '../util/form_builder_image_picker.dart';

class AuthorCreateForm extends StatefulWidget {

  const AuthorCreateForm({Key? key}) : super(key: key);

  @override
  State<AuthorCreateForm> createState() => _AuthorCreateFormState();

}

class _AuthorCreateFormState extends State<AuthorCreateForm> {

  final _formKey = GlobalKey<FormBuilderState>();
  bool isProfileImageSelected = false;
  Uint8List? imageBytes;

  void onCreate(BuildContext context) {
    FormBuilderState? formState = _formKey.currentState;

    if (formState != null && formState.saveAndValidate()) {

      Map<String, dynamic>? values = formState.value;

      BlocProvider.of<AuthorBloc>(context).add(
        CreateAuthor(
          displayName: values['displayName'],
          title: values['displayName'],
          imageBytes: values['image'],
        ));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Creating...')),
      );

    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthorBloc, AuthorState>(
      listener: (context, state) {
        if (state is AuthorErrorState) {
          AuthorErrorState errorState = state;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(errorState.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                skipDisabled: true,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilderTextField(
                      name: 'displayName',
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),

                    FormBuilderTextField(
                      name: 'title',
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),

                    FormBuilderImagePicker(
                      name: 'image',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => onCreate(context),
                        child: const Text('Create'),
                      ),
                    ),

                  ],
                )
            )
          ],
        );
      },
    );



  }
}

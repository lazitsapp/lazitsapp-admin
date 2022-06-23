import 'dart:typed_data';

import 'package:author_repository/author_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lazitsapp_admin/bloc/author/author_bloc.dart';
import 'package:lazitsapp_admin/widget/util/image_file_picker.dart';


class AuthorUpdateForm extends StatefulWidget {

  final Author author;

  const AuthorUpdateForm(this.author, {Key? key}) : super(key: key);

  @override
  State<AuthorUpdateForm> createState() => _AuthorUpdateFormState();

}

class _AuthorUpdateFormState extends State<AuthorUpdateForm> {

  final _formKey = GlobalKey<FormBuilderState>();
  bool isProfileImageChanged = false;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
  }

  void onSave() {
    FormBuilderState? formState = _formKey.currentState;

    if (formState != null && formState.saveAndValidate()) {

      Map<String, dynamic>? values = formState.value;

      Author author = widget.author.copyWith(
        displayName: values['displayName'],
        title: values['title'],
      );

      if (isProfileImageChanged) {
        BlocProvider.of<AuthorBloc>(context)
          .add(UpdateAuthorWithProfileImage(author, imageBytes!));
      } else {
        BlocProvider.of<AuthorBloc>(context)
          .add(UpdateAuthor(author));
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saving...')),
      );

    }

  }

  @override
  Widget build(BuildContext context) {

    Author author = widget.author;

    return Column(
      children: [

        FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          skipDisabled: true,
          child: Column(
            children: [

              FormBuilderTextField(
                name: 'id',
                decoration: const InputDecoration(labelText: 'Id'),
                readOnly: true,
                initialValue: author.authorId,
              ),

              FormBuilderTextField(
                name: 'displayName',
                decoration: const InputDecoration(labelText: 'Name'),
                initialValue: author.displayName,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),

              FormBuilderTextField(
                name: 'title',
                decoration: const InputDecoration(labelText: 'Title'),
                initialValue: author.title,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),

              ImageFilePicker(
                initialValue: author.photoUrl,
                onImageFileSelected: (imageBytes) {
                  setState(() {
                    isProfileImageChanged = true;
                    this.imageBytes = imageBytes;
                  });
                }
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: onSave,
                child: const Text('Save'),
              ),

            ],
          )
        )

      ],
    );


  }
}

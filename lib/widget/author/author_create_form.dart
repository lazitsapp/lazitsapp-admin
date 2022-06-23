import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lazitsapp_admin/widget/util/image_file_picker.dart';

class AuthorCreateForm extends StatefulWidget {

  const AuthorCreateForm({Key? key}) : super(key: key);

  @override
  State<AuthorCreateForm> createState() => _AuthorCreateFormState();

}

class _AuthorCreateFormState extends State<AuthorCreateForm> {

  final _formKey = GlobalKey<FormState>();
  bool isProfileImageSelected = false;
  Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          skipDisabled: true,

          child: Column(
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

              ImageFilePicker(
                onImageFileSelected: (imageBytes) {
                  setState(() {
                    isProfileImageSelected = true;
                    this.imageBytes = imageBytes;
                  });
                }
              ),

            ],
          )
        )
      ],
    );

  }
}

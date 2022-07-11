import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lazitsapp_admin/bloc/author/author_bloc.dart';
import 'package:lazitsapp_admin/widget/util/show_alert_dialog.dart';

import '../util/form_builder_image_picker.dart';

class AuthorUpdateForm extends StatefulWidget {

  final Author author;

  const AuthorUpdateForm(this.author, {Key? key}) : super(key: key);

  @override
  State<AuthorUpdateForm> createState() => _AuthorUpdateFormState();

}

class _AuthorUpdateFormState extends State<AuthorUpdateForm> {

  final _formKey = GlobalKey<FormBuilderState>();
  bool isProfileImageChanged = false;

  @override
  void initState() {
    super.initState();
  }

  void onSave() {
    FormBuilderState? formState = _formKey.currentState;
    if (formState != null && formState.saveAndValidate()) {
      Map<String, dynamic>? values = formState.value;
      BlocProvider.of<AuthorBloc>(context)
        .add(UpdateAuthor(
          authorId: values['authorId']!,
          displayName: values['displayName']!,
          title: values['title']!,
          photoUrl: widget.author.photoUrl,
          imageBytes: values['image']
        ));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saving...')),
      );
    }
  }

  void onDelete(BuildContext context) {
    showAlertDialog(
      title: 'Delete Author',
      content: 'Are you sure you want to delete the author?',
      context: context,
      onAccept: () {
        BlocProvider.of<AuthorBloc>(context).add(DeleteAuthor(widget.author));
        Navigator.of(context, rootNavigator: true).pop();
      },
      acceptButtonText: 'Delete Author',
    );
  }

  @override
  Widget build(BuildContext context) {

    Author author = widget.author;

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
          children: [

            FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                skipDisabled: true,
                child: Column(
                  children: [

                    FormBuilderTextField(
                      name: 'authorId',
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

                    FormBuilderImagePicker(
                        name: 'image',
                        initialImageUrl: author.photoUrl,
                        onChanged: (imageBytes) {
                          setState(() {
                            isProfileImageChanged = true;
                          });
                        }
                    ),

                    const SizedBox(height: 16),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: onSave,
                          child: const Text('Save'),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () => onDelete(context),
                          child: const Text('Delete'),
                        ),
                      ],
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

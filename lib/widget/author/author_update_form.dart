import 'dart:typed_data';

import 'package:author_repository/author_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/bloc/author/author_bloc.dart';
import 'package:lazitsapp_admin/widget/form/validator_functions.dart';
import 'package:lazitsapp_admin/widget/util/image_file_picker.dart';

class AuthorDetailForm extends StatefulWidget {

  final Author author;

  const AuthorDetailForm(this.author, {Key? key}) : super(key: key);

  @override
  State<AuthorDetailForm> createState() => _AuthorDetailFormState();
}

class _AuthorDetailFormState extends State<AuthorDetailForm> {

  final _formKey = GlobalKey<FormState>();
  late Author updatedAuthor;
  bool isProfileImageChanged = false;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    updatedAuthor = widget.author.copyWith();
  }

  void onSave() {
    FormState formState = _formKey.currentState!;
    if (formState.validate()) {

      if (isProfileImageChanged) {
        BlocProvider.of<AuthorBloc>(context)
          .add(UpdateAuthorWithProfileImage(
            updatedAuthor,
            imageBytes!
        ));
      } else {
        BlocProvider.of<AuthorBloc>(context)
          .add(UpdateAuthor(updatedAuthor));
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
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // Id
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Id'),
                initialValue: author.authorId,
              ),

              // Name
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                initialValue: author.displayName,
                validator: requiredValidator(),
                onChanged: (String? displayName) {
                  setState(() {
                    updatedAuthor = updatedAuthor.copyWith(
                      displayName: displayName
                    );
                  });
                },
              ),

              // Short description
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                initialValue: author.title,
                validator: requiredValidator(),
                onChanged: (String? title) {
                  setState(() {
                    updatedAuthor = updatedAuthor.copyWith(
                      title: title
                    );
                  });
                },
              ),

              const SizedBox(height: 16),

              ImageFilePicker(
                currentImageUrl: author.photoUrl,
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
          ),
        )
      ],
    );


  }
}

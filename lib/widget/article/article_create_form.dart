import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/widget/util/form_builder_media_picker.dart';
import 'package:lazitsapp_admin/widget/util/util.dart';
import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lazitsapp_admin/widget/util/form_builder_author_selector.dart';
import 'package:lazitsapp_admin/widget/util/form_builder_category_selector.dart';

import 'package:lazitsapp_shared/lazitsapp_shared.dart';
// import '../../bloc/article/article_bloc.dart';

class ArticleCreateForm extends StatefulWidget {

  const ArticleCreateForm({
    Key? key
  }) : super(key: key);

  @override
  State<ArticleCreateForm> createState() => _ArticleCreateFormState();
}

class _ArticleCreateFormState extends State<ArticleCreateForm> {

  final _formKey = GlobalKey<FormBuilderState>();

  void onCreate(BuildContext context) {
    FormBuilderState? formState = _formKey.currentState;

    if (formState != null && formState.saveAndValidate()) {

      Map<String, dynamic>? values = formState.value;

      BlocProvider.of<ArticleBloc>(context).add(
        CreateArticle(
          mediaBytes: values['media']
          // displayName: values['displayName'],
          // title: values['displayName'],
          // imageBytes: values['image'],
        )
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Creating...')),
      );

    }

  }

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

                // FormBuilderTextField(
                //   name: 'name',
                //   decoration: const InputDecoration(labelText: 'Name'),
                //   validator: FormBuilderValidators.compose([
                //     FormBuilderValidators.required(),
                //   ]),
                //   keyboardType: TextInputType.text,
                //   textInputAction: TextInputAction.next,
                // ),
                //
                // FormBuilderDropdown<ArticleType>(
                //   name: 'articleCategoryType',
                //   decoration: const InputDecoration(labelText: 'Type'),
                //   items: ArticleType.values.map((type) {
                //     return DropdownMenuItem<ArticleType>(
                //       value: type,
                //       child: Text(type.toString())
                //     );
                //   }).toList(),
                // ),
                //
                // const FormBuilderAuthorSelector(),
                //
                // const FormBuilderCategorySelector(),
                //
                // FormBuilderTextField(
                //   name: 'fullDescription',
                //   decoration: const InputDecoration(labelText: 'Full description'),
                //   validator: FormBuilderValidators.compose([
                //     FormBuilderValidators.required(),
                //   ]),
                //   keyboardType: TextInputType.text,
                //   textInputAction: TextInputAction.next,
                // ),
                //
                // FormBuilderTextField(
                //   name: 'mediaResourceUrl',
                //   decoration: const InputDecoration(labelText: 'Media resource url'),
                //   readOnly: true,
                // ),

                FormBuilderMediaPicker(name: 'media'),

                // FormBuilderImagePicker(
                //   name: 'thumbnailImage',
                //   labelText: 'Thumbnail image',
                // ),
                //
                // FormBuilderImagePicker(
                //   name: 'thumbnailImage',
                //   labelText: 'Square image',
                // ),
                //
                // FormBuilderImagePicker(
                //   name: 'thumbnailImage',
                //   labelText: 'Portrait image',
                // ),

                const SizedBox(height: 16),

                SizedBox(
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

  }

}

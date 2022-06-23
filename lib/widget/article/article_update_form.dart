import 'package:article_repository/article_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ArticleUpdateForm extends StatefulWidget {

  final Article article;

  const ArticleUpdateForm(this.article, {Key? key}) : super(key: key);

  @override
  State<ArticleUpdateForm> createState() => _ArticleUpdateFormState();
}

class _ArticleUpdateFormState extends State<ArticleUpdateForm> {

  final _formKey = GlobalKey<FormBuilderState>();

  void onSave() {


  }

  @override
  Widget build(BuildContext context) {

    Article article = widget.article;

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
                initialValue: article.id,
              ),

              FormBuilderTextField(
                name: 'playCount',
                decoration: const InputDecoration(labelText: 'Play count'),
                readOnly: true,
                initialValue: article.playCount.toString(),
              ),

              FormBuilderTextField(
                name: 'mediaResourceUrl',
                decoration: const InputDecoration(labelText: 'Media resource url'),
                readOnly: true,
                initialValue: article.mediaResourceUrl,
              ),

              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Name'),
                initialValue: article.name,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),

              FormBuilderTextField(
                name: 'fullDescription',
                decoration: const InputDecoration(labelText: 'Full description'),
                initialValue: article.fullDescription,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),

              FormBuilderDropdown<ArticleType>(
                name: 'articleCategoryType',
                initialValue: article.articleType,
                items: ArticleType.values.map((type) {
                  return DropdownMenuItem<ArticleType>(
                      value: type,
                      child: Text(type.toString())
                  );
                }).toList(),
              )

            ],
          )
        )
      ],
    );

  }

}

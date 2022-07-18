import 'package:lazitsapp_admin/widget/util/util.dart';
import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lazitsapp_admin/widget/util/form_builder_author_selector.dart';
import 'package:lazitsapp_admin/widget/util/form_builder_category_selector.dart';

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
                name: 'name',
                decoration: const InputDecoration(labelText: 'Name'),
                initialValue: article.name,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),

              FormBuilderDropdown<ArticleType>(
                name: 'articleCategoryType',
                decoration: const InputDecoration(labelText: 'Type'),
                initialValue: article.articleType,
                items: ArticleType.values.map((type) {
                  return DropdownMenuItem<ArticleType>(
                      value: type,
                      child: Text(type.toString())
                  );
                }).toList(),
              ),

              FormBuilderAuthorSelector(
                initialValue: article.author,
              ),

              FormBuilderCategorySelector(
                initialValue: article.category,
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

              FormBuilderTextField(
                name: 'mediaResourceUrl',
                decoration: const InputDecoration(labelText: 'Media resource url'),
                readOnly: true,
                initialValue: article.mediaResourceUrl,
              ),

              FormBuilderImagePicker(
                name: 'thumbnailImage',
                labelText: 'Thumbnail image',
                initialImageUrl: article.getCoverImageUrl(ArticleImageVersion.thumbnail),
              ),

              FormBuilderImagePicker(
                name: 'squareImage',
                labelText: 'Square image',
                initialImageUrl: article.getCoverImageUrl(ArticleImageVersion.square),
              ),

              FormBuilderImagePicker(
                name: 'portraitImage',
                labelText: 'Portrait image',
                initialImageUrl: article.getCoverImageUrl(ArticleImageVersion.portrait),
              ),

              FormBuilderTextField(
                name: 'playCount',
                decoration: const InputDecoration(labelText: 'Play count'),
                readOnly: true,
                initialValue: article.playCount.toString(),
              ),


            ],
          )
        )
      ],
    );

  }

}

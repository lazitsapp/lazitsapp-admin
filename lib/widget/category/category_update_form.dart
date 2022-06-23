import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lazitsapp_admin/bloc/category/category_bloc.dart';

class CategoryUpdateForm extends StatefulWidget {

  final ArticleCategory articleCategory;

  const CategoryUpdateForm(this.articleCategory, {Key? key}) : super(key: key);

  @override
  State<CategoryUpdateForm> createState() => _CategoryUpdateFormState();
}

class _CategoryUpdateFormState extends State<CategoryUpdateForm> {

  final _formKey = GlobalKey<FormBuilderState>();

  void onSave() {
    FormBuilderState? formState = _formKey.currentState;

    if (formState != null && formState.saveAndValidate()) {

      Map<String, dynamic>? values = formState.value;

      ArticleCategory category = widget.articleCategory.copyWith(
        name: values['name'],
        shortDescription: values['shortDescription'],
        priority: values['priority'],
        articleCategoryType: values['articleCategoryType'] as ArticleCategoryType
      );

      BlocProvider.of<CategoryBloc>(context)
        .add(UpdateCategory(category));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saving...')),
      );

    }

  }

  @override
  Widget build(BuildContext context) {

      ArticleCategory category = widget.articleCategory;

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
                  initialValue: category.id,
                ),

                FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(labelText: 'Name'),
                  initialValue: category.name,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),

                FormBuilderTextField(
                  name: 'shortDescription',
                  decoration: const InputDecoration(labelText: 'Short description'),
                  initialValue: category.shortDescription,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),


                FormBuilderTextField(
                  name: 'priority',
                  decoration: const InputDecoration(labelText: 'Priority'),
                  initialValue: category.priority.toString(),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric()
                  ]),
                  valueTransformer: (text) => num.tryParse(text!),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),

                FormBuilderDropdown<ArticleCategoryType>(
                  name: 'articleCategoryType',
                  initialValue: category.articleCategoryType,
                  items: ArticleCategoryType.values.map((type) {
                    return DropdownMenuItem<ArticleCategoryType>(
                      value: type,
                      child: Text(type.toString())
                    );
                  }).toList(),

                ),

                FormBuilderCheckbox(
                  name: 'isActive',
                  title: const Text('Active'),
                  initialValue: category.isActive,
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

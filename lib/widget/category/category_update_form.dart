import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lazitsapp_admin/bloc/category/category_bloc.dart';

import '../util/show_alert_dialog.dart';

class CategoryUpdateForm extends StatefulWidget {

  final Category category;

  const CategoryUpdateForm(this.category, {Key? key}) : super(key: key);

  @override
  State<CategoryUpdateForm> createState() => _CategoryUpdateFormState();
}

class _CategoryUpdateFormState extends State<CategoryUpdateForm> {

  final _formKey = GlobalKey<FormBuilderState>();

  void onSave() {
    FormBuilderState? formState = _formKey.currentState;
    if (formState != null && formState.saveAndValidate()) {
      Map<String, dynamic>? values = formState.value;
      BlocProvider.of<CategoryBloc>(context)
        .add(UpdateCategory(
          articleId: values['articleId'],
          name: values['name'],
          shortDescription: values['shortDescription'],
          categoryType: values['articleCategoryType'],
          priority: values['priority'],
          isActive: values['isActive'],
        ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Creating...')),
      );
    }
  }

  void onDelete(BuildContext context) {
    showAlertDialog(
      title: 'Delete Category',
      content: 'Are you sure you want to delete the category?',
      context: context,
      onAccept: () {
        BlocProvider.of<CategoryBloc>(context).add(
          DeleteCategory(
            category: widget.category,
            onCompleted: () => Navigator.of(context, rootNavigator: true).pop()
          )
        );
      },
      acceptButtonText: 'Delete Category',
    );
  }

  @override
  Widget build(BuildContext context) {

      Category category = widget.category;

      return Column(
        children: [

          FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            skipDisabled: true,
            child: Column(
              children: [

                FormBuilderTextField(
                  name: 'articleId',
                  decoration: const InputDecoration(labelText: 'Id'),
                  readOnly: true,
                  initialValue: category.categoryId,
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

                FormBuilderDropdown<CategoryType>(
                  name: 'articleCategoryType',
                  initialValue: category.categoryType,
                  items: CategoryType.values.map((type) {
                    return DropdownMenuItem<CategoryType>(
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

  }

}

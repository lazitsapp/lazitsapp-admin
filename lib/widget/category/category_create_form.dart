import 'package:lazitsapp_repositories/lazitsapp_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_shared/lazitsapp_shared.dart';

class CategoryCreateForm extends StatefulWidget {
  const CategoryCreateForm({Key? key}) : super(key: key);

  @override
  State<CategoryCreateForm> createState() => _CategoryCreateFormState();
}

class _CategoryCreateFormState extends State<CategoryCreateForm> {

  final _formKey = GlobalKey<FormBuilderState>();

  void onCreate(BuildContext context) {
    FormBuilderState? formState = _formKey.currentState;

    if (formState != null && formState.saveAndValidate()) {
      Map<String, dynamic>? values = formState.value;

      BlocProvider.of<CategoryBloc>(context).add(
        CreateCategory(
          name: values['name'],
          categoryType: values['articleCategoryType'],
          shortDescription: values['shortDescription'],
          priority: values['priority'],
          isActive: values['isActive'],
          onCompleted: () => GoRouter.of(context).pop(),
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

                FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),

                FormBuilderTextField(
                  name: 'shortDescription',
                  decoration: const InputDecoration(
                      labelText: 'Short description'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),

                FormBuilderDropdown<CategoryType>(
                  name: 'articleCategoryType',
                  items: CategoryType.values.map((type) {
                    return DropdownMenuItem<CategoryType>(
                        value: type,
                        child: Text(type.toString())
                    );
                  }).toList(),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),

                FormBuilderTextField(
                  name: 'priority',
                  decoration: const InputDecoration(labelText: 'Priority'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric()
                  ]),
                  valueTransformer: (text) => num.tryParse(text!),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),

                FormBuilderCheckbox(
                  name: 'isActive',
                  title: const Text('Active'),
                  initialValue: false,
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    onCreate(context);
                  },
                  child: const Text('Create'),
                ),

              ],
            )
        )

      ],
    );
  }

}

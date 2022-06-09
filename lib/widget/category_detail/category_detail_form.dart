import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazitsapp_admin/bloc/category/category_bloc.dart';
import 'package:lazitsapp_admin/widget/form/checkbox_form_field.dart';

class CategoryDetailForm extends StatefulWidget {

  final ArticleCategory articleCategory;
  ArticleCategory newArticleCategory;

  CategoryDetailForm(this.articleCategory, {Key? key}) :
    newArticleCategory = articleCategory.copyWith(),
    super(key: key);

  @override
  State<CategoryDetailForm> createState() => _CategoryDetailFormState();
}

class _CategoryDetailFormState extends State<CategoryDetailForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

      ArticleCategory articleCategory = widget.articleCategory;
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
                  initialValue: articleCategory.id,
                ),

                // Name
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  initialValue: articleCategory.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Category name is required';
                    }
                    return null;
                  },
                  onChanged: (String? name) {
                    widget.newArticleCategory = widget.newArticleCategory
                      .copyWith(
                        name: name
                      );
                  },
                ),

                // Short description
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Short description'),
                  initialValue: articleCategory.shortDescription,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Short description is required';
                    }
                    return null;
                  },
                  onChanged: (String? shortDescription) {
                    widget.newArticleCategory = widget.newArticleCategory
                      .copyWith(
                        shortDescription: shortDescription
                      );
                  },
                ),

                // Priority
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Priority'),
                  initialValue: articleCategory.priority.toString(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Priority is required';
                    }
                    return null;
                  },
                  onChanged: (String? priority) {
                    if (priority == null) {
                      widget.newArticleCategory = widget.newArticleCategory
                        .copyWith(
                          priority: 0
                        );
                    } else {
                      widget.newArticleCategory = widget.newArticleCategory
                        .copyWith(
                          priority: int.parse(priority)
                        );
                    }
                  },

                ),

                // Category type
                DropdownButtonFormField<ArticleCategoryType>(
                  decoration: const InputDecoration(labelText: 'Category type'),
                  value: articleCategory.articleCategoryType,
                  items: ArticleCategoryType.values.map((articleCategoryType) {
                    return DropdownMenuItem<ArticleCategoryType>(
                      value: articleCategoryType,
                      child: Text(articleCategoryType.toString())
                    );
                  }).toList(),
                  onChanged: (ArticleCategoryType? articleCategoryType) {
                    widget.newArticleCategory = widget.newArticleCategory
                      .copyWith(
                        articleCategoryType: articleCategoryType
                      );
                  },
                ),

                // isActive
                CheckboxFormField(
                  title: const Text('Active'),
                  initialValue: articleCategory.isActive,
                  onSaved: (onSaved) {},
                  validator: (validator) {},
                  onChanged: (bool? isActive) {
                    widget.newArticleCategory = widget.newArticleCategory
                      .copyWith(
                        isActive: isActive
                      );
                  },
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    FormState formState = _formKey.currentState!;

                    if (formState.validate()) {

                      BlocProvider.of<CategoryBloc>(context)
                        .add(UpdateCategory(widget.newArticleCategory));
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saving...')),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          )
        ],
      );




  }

}

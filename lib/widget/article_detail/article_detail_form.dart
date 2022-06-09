import 'package:article_repository/article_repository.dart';
import 'package:flutter/material.dart';

class ArticleUpdateForm extends StatefulWidget {

  final Article article;
  Article newArticle;

  ArticleUpdateForm(this.article, {Key? key}) :
      newArticle = article.copyWith(),
      super(key: key);

  @override
  State<ArticleUpdateForm> createState() => _ArticleUpdateFormState();
}

class _ArticleUpdateFormState extends State<ArticleUpdateForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    Article articleCategory = widget.article;
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
                  widget.newArticle = widget.newArticle
                      .copyWith(
                      name: name
                  );
                },
              ),

              // // Short description
              // TextFormField(
              //   decoration: const InputDecoration(labelText: 'Short description'),
              //   initialValue: articleCategory.name,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Category name is required';
              //     }
              //     return null;
              //   },
              //   onChanged: (String? shortDescription) {
              //     widget.newArticle = widget.newArticle
              //         .copyWith(
              //         shortDescription: shortDescription
              //     );
              //   },
              // ),
              //
              // // Priority
              // TextFormField(
              //   decoration: const InputDecoration(labelText: 'Priority'),
              //   initialValue: articleCategory.priority.toString(),
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [
              //     FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
              //   ],
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Priority is required';
              //     }
              //     return null;
              //   },
              //   onChanged: (String? priority) {
              //     if (priority == null) {
              //       widget.newArticle = widget.newArticle
              //           .copyWith(
              //           priority: 0
              //       );
              //     } else {
              //       widget.newArticle = widget.newArticle
              //           .copyWith(
              //           priority: int.parse(priority)
              //       );
              //     }
              //   },
              //
              // ),
              //
              // // Category type
              // DropdownButtonFormField<ArticleCategoryType>(
              //   decoration: const InputDecoration(labelText: 'Category type'),
              //   value: articleCategory.articleCategoryType,
              //   items: ArticleCategoryType.values.map((articleCategoryType) {
              //     return DropdownMenuItem<ArticleCategoryType>(
              //         value: articleCategoryType,
              //         child: Text(articleCategoryType.toString())
              //     );
              //   }).toList(),
              //   onChanged: (ArticleCategoryType? articleCategoryType) {
              //     widget.newArticle = widget.newArticle
              //         .copyWith(
              //         articleCategoryType: articleCategoryType
              //     );
              //   },
              // ),
              //
              // // isActive
              // CheckboxFormField(
              //   title: const Text('Active'),
              //   initialValue: articleCategory.isActive,
              //   onSaved: (onSaved) {},
              //   validator: (validator) {},
              //   onChanged: (bool? isActive) {
              //     print(isActive);
              //     widget.newArticle = widget.newArticle
              //         .copyWith(
              //         isActive: isActive
              //     );
              //   },
              // ),
              //
              // const SizedBox(height: 16),
              //
              // ElevatedButton(
              //   onPressed: () {
              //     // Validate returns true if the form is valid, or false otherwise.
              //     FormState formState = _formKey.currentState!;
              //
              //     if (formState.validate()) {
              //
              //       BlocProvider.of<CategoryBloc>(context)
              //           .add(UpdateCategory(widget.newArticle));
              //       // If the form is valid, display a snackbar. In the real world,
              //       // you'd often call a server or save the information in a database.
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(content: Text('Saving...')),
              //       );
              //     }
              //   },
              //   child: const Text('Save'),
              // ),
            ],
          ),
        )
      ],
    );




  }

}

import '../../../models/category.dart';
import '../provider/category_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../widgets/category_image_card.dart';
import '../../../widgets/custom_text_field.dart';

class CategorySubmitForm extends StatelessWidget {
  final Category? category;

  const CategorySubmitForm({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //TODO: should complete call setDataForUpdateCategory
    context.categoryProvider.setDataForUpdateCategory(category);
    return SingleChildScrollView(
      child: Form(
        key: context.categoryProvider.addCategoryFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.3,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(defaultPadding),
              Consumer<CategoryProvider>(
                builder: (context, catProvider, child) {
                  return CategoryImageCard(
                    labelText: "Category",
                    imageFile: catProvider.selectedImage,
                    imageUrlForUpdateImage: category?.image,
                    onTap: () {
                      catProvider.pickImage();
                    },
                  );
                },
              ),
              Gap(defaultPadding),
              CustomTextField(
                controller: context.categoryProvider.categoryNameCtrl,
                labelText: 'Category Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              Gap(defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: Text('Cancel'),
                  ),
                  Gap(defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      // Validate and save the form
                      if (context.categoryProvider.addCategoryFormKey.currentState!.validate()) {
                        context.categoryProvider.addCategoryFormKey.currentState!.save();
                        context.categoryProvider.submitCategory();
                        //TODO: should complete call submitCategory
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// How to show the category popup
void showAddCategoryForm(BuildContext context, Category? category) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(child: Text('Add Category'.toUpperCase(), style: TextStyle(color: primaryColor))),
        content: CategorySubmitForm(category: category),
      );
    },
  );
}

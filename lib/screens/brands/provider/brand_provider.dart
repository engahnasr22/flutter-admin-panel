import 'package:admin/models/api_response.dart';
import 'package:admin/utility/snack_bar_helper.dart';

import '../../../models/brand.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_services.dart';

class BrandProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addBrandFormKey = GlobalKey<FormState>();
  TextEditingController brandNameCtrl = TextEditingController();
  SubCategory? selectedSubCategory;
  Brand? brandForUpdate;

  BrandProvider(this._dataProvider);

  //TODO: should complete addBrand
  addBrand() async {
    try {
      Map<String, dynamic> brand = {
        "name": brandNameCtrl.text,
        "subcategoryId": selectedSubCategory?.sId
      };
      final response = await service.addItem(
          endpointUrl: 'brands', itemData: brand);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllBrands();
          print('Sub Category Added Successfully');
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to Added Sub Category ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An error is occurred: $e');
      rethrow;
    }
  }

  //TODO: should complete updateBrand
  updateBrand() async {
    try {
      if (brandForUpdate != null) {
        Map<String, dynamic> subCategory = {
          "name": brandNameCtrl.text,
          "subcategoryId": selectedSubCategory?.sId
        };
        final response = await service.updateItem(
            endpointUrl: 'brands',
            itemData: subCategory,
            itemId: brandForUpdate?.sId ?? '');
        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            clearFields();
            SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
            _dataProvider.getAllCategory();
            print('Brand Updated Successfully');
          } else {
            SnackBarHelper.showErrorSnackBar(
                'Failed to Update Brand ${apiResponse.message}');
          }
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Error ${response.body?['message'] ?? response.statusText}');
        }
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An error is occurred: $e');
      rethrow;
    }
  }

  //TODO: should complete submitBrand

  submitBrand() {
    if (brandForUpdate != null) {
      updateBrand();
    } else {
      addBrand();
    }
  }

  //TODO: should complete deleteBrand
  deleteBrand(Brand brand) async {
    try {
      Response response = await service.deleteItem(
          endpointUrl: 'brands', itemId: brand.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllBrands();
          print('Brand Deleted successfully');
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to Delete Brand ${apiResponse.message}');
        }
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  //? set data for update on editing
  setDataForUpdateBrand(Brand? brand) {
    if (brand != null) {
      brandForUpdate = brand;
      brandNameCtrl.text = brand.name ?? '';
      selectedSubCategory = _dataProvider.subCategories.firstWhereOrNull(
          (element) => element.sId == brand.subcategoryId?.sId);
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update brand
  clearFields() {
    brandNameCtrl.clear();
    selectedSubCategory = null;
    brandForUpdate = null;
  }

  updateUI() {
    notifyListeners();
  }
}

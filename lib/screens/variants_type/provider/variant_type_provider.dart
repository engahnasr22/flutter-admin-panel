import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/variant_type.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';

class VariantsTypeProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addVariantsTypeFormKey = GlobalKey<FormState>();
  TextEditingController variantNameCtrl = TextEditingController();
  TextEditingController variantTypeCtrl = TextEditingController();

  VariantType? variantTypeForUpdate;



  VariantsTypeProvider(this._dataProvider);


  //Add VariantType Call Function
  addVariantType() async {
    try {
      Map<String, dynamic> variantType = {
        "name": variantNameCtrl.text,
        "type": variantTypeCtrl.text
      };
      final response = await service.addItem(
          endpointUrl: 'variantTypes', itemData: variantType);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllVariantType();
          print('Variant Type Added Successfully');
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to Added Variant Type ${apiResponse.message}');
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

  //Update VariantType Call Function
  updateVariantType() async {
    try {
      if (variantTypeForUpdate != null) {
        Map<String, dynamic> variantType = {
          "name": variantNameCtrl.text,
          "type": variantTypeCtrl.text
        };
        final response = await service.updateItem(
            endpointUrl: 'variantTypes',
            itemData: variantType,
            itemId: variantTypeForUpdate?.sId ?? '');
        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            clearFields();
            SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
            _dataProvider.getAllVariantType();
            print('Variant Type Updated Successfully');
          } else {
            SnackBarHelper.showErrorSnackBar(
                'Failed to Update Variant Type ${apiResponse.message}');
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

  //Submit VariantType Call Function
  submitVariantType() {
    if (variantTypeForUpdate != null) {
      updateVariantType();
    } else {
      addVariantType();
    }
  }
  //Delete VariantType Call Function
  deleteVariantType(VariantType variantType) async {
    try {
      Response response = await service.deleteItem(
          endpointUrl: 'variantTypes', itemId: variantType.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllBrands();
          print('Variant Type Deleted successfully');
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to Delete Variant Type ${apiResponse.message}');
        }
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }


  setDataForUpdateVariantTYpe(VariantType? variantType) {
    if (variantType != null) {
      variantTypeForUpdate = variantType;
      variantNameCtrl.text = variantType.name ?? '';
      variantTypeCtrl.text = variantType.type ?? '';
    } else {
      clearFields();
    }
  }

  clearFields() {
    variantNameCtrl.clear();
    variantTypeCtrl.clear();
    variantTypeForUpdate = null;
  }
}

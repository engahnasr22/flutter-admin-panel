import 'package:admin/main.dart';
import 'package:admin/utility/extensions.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/product.dart';
import 'add_product_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';

class ProductListSection extends StatelessWidget {
  const ProductListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Products",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: Consumer<DataProvider>(
              builder: (context, dataProvider, child) {
                return DataTable(
                  columnSpacing: defaultPadding,
                  // minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Expanded(child: Text("Product Name")),
                    ),
                    DataColumn(
                      label: Expanded(child: Text("Category")),
                    ),
                    DataColumn(
                      label: Expanded(child: Text("Sub Category")),
                    ),
                    DataColumn(
                      label: Expanded(child: Text("Price")),
                    ),
                    DataColumn(
                      label: Expanded(child: Text("Edit")),
                    ),
                    DataColumn(
                      label: Expanded(child: Text("Delete")),
                    ),
                  ],
                  rows: List.generate(
                    dataProvider.products.length,
                    (index) => productDataRow(
                      dataProvider.products[index],
                      edit: () {
                        showAddProductForm(
                            context, dataProvider.products[index]);
                      },
                      delete: () {
                        //Delete Product Configuration
                        context.dashBoardProvider
                            .deleteProduct(dataProvider.products[index]);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

DataRow productDataRow(Product productInfo,
    {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(children: [
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: ClipOval(
                child: SizedBox.fromSize(
                child: Image.network(
                  fit: BoxFit.cover,
                  productInfo.images?.first.url ?? '',
                  height: 40,
                  width: 40,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Icon(Icons.error);
                  },
                ),
              ),
            ),
          ),
          Container(
            width: 300,
            alignment: Alignment.centerLeft,
            child: Text(
              productInfo.name ?? '',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              maxLines: 2,
              // Enable text wrapping
            ),
          )
        ]),
      ),
      DataCell(Text(productInfo.proCategoryId?.name ?? '')),
      DataCell(Text(productInfo.proSubCategoryId?.name ?? '')),
      DataCell(
        Text('${productInfo.price}'),
      ),
      DataCell(IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ))),
      DataCell(IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ))),
    ],
  );
}

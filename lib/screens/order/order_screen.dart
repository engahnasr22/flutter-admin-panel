import 'components/order_header.dart';
import 'components/order_list_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import '../../widgets/custom_dropdown.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            OrderHeader(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              "My Orders",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Gap(20),
                          SizedBox(
                            width: 280,
                            child: CustomDropdown(
                              hintText: 'Filter Order By status',
                              initialValue: 'All order',
                              items: ['All order', 'pending', 'processing', 'shipped', 'delivered', 'cancelled'],
                              displayItem: (val) => val,
                              onChanged: (newValue) {
                                if (newValue?.toLowerCase() == 'all order') {
                                  //TODO: should complete call filterOrders
                                } else {
                                  //TODO: should complete call filterOrders
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select status';
                                }
                                return null;
                              },
                            ),
                          ),
                          Gap(40),
                          IconButton(
                              onPressed: () {
                                //TODO: should complete call getAllOrders
                              },
                              icon: Icon(Icons.refresh)),
                        ],
                      ),
                      Gap(defaultPadding),
                      OrderListSection(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

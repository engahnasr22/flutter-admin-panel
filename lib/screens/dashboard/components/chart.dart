import '../../../core/data/data_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: _buildPieChartSelectionData(context),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                    return Text(
                      '${0}', //TODO: should complete Make this order number dynamic bt calling calculateOrdersWithStatus
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                    );
                  },
                ),
                SizedBox(height: defaultPadding),
                Text("Order")
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSelectionData(BuildContext context) {
    final DataProvider dataProvider = Provider.of<DataProvider>(context);

    //TODO: should complete Make this order number dynamic bt calling calculateOrdersWithStatus
    int totalOrder = 0;
    int pendingOrder = 0;
    int processingOrder = 0;
    int cancelledOrder = 0;
    int shippedOrder = 0;
    int deliveredOrder = 0;

    List<PieChartSectionData> pieChartSelectionData = [
      PieChartSectionData(
        color: Color(0xFFFFCF26),
        value: pendingOrder.toDouble(),
        showTitle: false,
        radius: 20,
      ),
      PieChartSectionData(
        color: Color(0xFFEE2727),
        value: cancelledOrder.toDouble(),
        showTitle: false,
        radius: 20,
      ),
      PieChartSectionData(
        color: Color(0xFF2697FF),
        value: shippedOrder.toDouble(),
        showTitle: false,
        radius: 20,
      ),
      PieChartSectionData(
        color: Color(0xFF26FF31),
        value: deliveredOrder.toDouble(),
        showTitle: false,
        radius: 20,
      ),
      PieChartSectionData(
        color: Colors.white,
        value: processingOrder.toDouble(),
        showTitle: false,
        radius: 20,
      ),
    ];

    return pieChartSelectionData;
  }
}


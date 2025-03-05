import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder/controllers/record_controller.dart';

// ignore: must_be_immutable
class GraphView extends StatelessWidget {
  GraphView({super.key});

  final List<double> waterData = [1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5];
  final RxBool isBarTouched = false.obs;
  RxInt touchedIndex = (-1).obs;

  List<String> getLast7Days() {
    return List.generate(7, (index) {
      DateTime day = DateTime.now().subtract(Duration(days: index));
      return DateFormat('dd/MM').format(day);
    }).reversed.toList(); // Sıralamayı eski → yeni yap
  }

  @override
  Widget build(BuildContext context) {
    List<String> last7Days = getLast7Days();

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Son 7 Günlük Su Tüketimi",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),

          // son 7 gündeki totalleri göstrtiyo
          ElevatedButton(
            onPressed: () {
              Get.find<Recordcontroller>().printLast7DaysRecords();
            },
            child: Text("Son 7 Gün Değerleri"),
          ),

          SizedBox(height: 10),
          Text(
            "Litre cinsinden gösterim",
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          SizedBox(height: 20),

          SizedBox(
            height: 500,
            child: BarChart(
              BarChartData(
                barGroups: List.generate(
                  waterData.length,
                  (index) => makeGroupData(index, waterData[index]),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles:
                          false, // Bu kısmı "false" yaparak y eksenindeki litreyi kaldırıyoruz
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        return Text(
                          last7Days[value.toInt()],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                groupsSpace: 16,

                barTouchData: BarTouchData(
                  enabled: true, // dokunma aktif edliryor
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.amber,
                    tooltipRoundedRadius: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      if (touchedIndex.value != groupIndex) return null;

                      return BarTooltipItem(
                        "${waterData[groupIndex]}L", // Sadece çubuğun üstüne gelindiğinde göster
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),

                  touchCallback: (event, touchResponse) {
                    if (touchResponse != null && touchResponse.spot != null) {
                      touchedIndex.value =
                          touchResponse.spot!.touchedBarGroupIndex;
                    } else {
                      touchedIndex.value =
                          -1; // Hiçbir çubuk seçili değilse gizle
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(
      "${value.toInt()}L",
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    );
  }

  BarChartGroupData makeGroupData(int x, double value) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
          ),
          width: 16,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }
}

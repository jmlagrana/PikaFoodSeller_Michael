
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../global/global.dart';
import '../model/menus.dart';

class SellerDashboardScreen extends StatelessWidget
{


  SellerDashboardScreen({Key? key}) :super(key: key);

  final streamChart = FirebaseFirestore.instance
  // /sellers/S0q2e5y8ysbjPVSJycd9zB228zn2/menus/1669046326757/items/1669046369392
      .collection("sellers").doc("S0q2e5y8ysbjPVSJycd9zB228zn2").collection("menus").doc("1669046326757").collection("items")
      .snapshots(includeMetadataChanges: true );

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text('KPI Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          StreamBuilder(
            stream: streamChart,
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
              if (snapshot.hasError){
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting){
                return const Text("Loading");
              }
              if (snapshot.data == null) {
                return const Text("Empty");
              }
              List listChart =
              snapshot.data!.docs.map((e){
                return {
                  'domain':e.data()['name'],
                  'measure':e.data()['purchased'],
                };
              }).toList();
              listChart.sort((a, b) => b['domain'].compareTo(a['domain']));
              return AspectRatio(
                aspectRatio: 16 / 29,
                child: DChartBar(
                  data: [
                    {
                      'id': 'Bar',
                      'data':listChart,
                    },
                  ],
                  domainLabelPaddingToAxisLine: 16,
                  axisLineTick: 2,
                  axisLinePointTick: 2,
                  axisLinePointWidth: 10,
                  axisLineColor: Colors.red,
                  measureLabelPaddingToAxisLine: 16,
                  barColor: (barData, index, id) => Colors.orange,
                  showBarValue: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}











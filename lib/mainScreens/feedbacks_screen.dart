import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FeedbacksScreen extends StatelessWidget
{
  FeedbacksScreen({Key? key}) :super(key: key);
  final streamChart = FirebaseFirestore.instance.collection('items').snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text('Rating Feedbacks')),
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
                  'domain':e.data()['rate1'],
                  'measure':e.data()['price'],
                };
              }).toList();
              // listChart.sort((a, b) => b['domain'].compareTo(a['domain']));
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: DChartBar(
                  data: [
                    {
                      'id': 'Bar',
                      'data':listChart,
                    },
                  ],
                  axisLineColor: Colors.black,
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









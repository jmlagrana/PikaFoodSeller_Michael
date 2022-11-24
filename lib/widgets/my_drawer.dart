import 'package:flutter/material.dart';
import 'package:pika_food/authentication/auth_screen.dart';
import 'package:pika_food/global/global.dart';
import 'package:pika_food/mainScreens/earnings_screen.dart';
import 'package:pika_food/mainScreens/feedbacks_screen.dart';
import 'package:pika_food/mainScreens/history_screen.dart';
import 'package:pika_food/mainScreens/home_screen.dart';
import 'package:pika_food/mainScreens/new_orders_screen.dart';
import 'package:pika_food/mainScreens/pending_screen.dart';
import 'package:pika_food/mainScreens/seller_dashboard.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/cart_Item_counter.dart';



class MyDrawer extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return Drawer(
      child: ListView(
        children: [
          //header drawer
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                    sharedPreferences!.getString("name")!,
                  style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold, fontFamily: "Train"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12,),

          //body drawer
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.black,),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.monetization_on, color: Colors.black,),
                  title: const Text(
                    "My Earnings",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const EarningsScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.dashboard, color: Colors.black,),
                  title: const Text(
                    "Dashboard",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>  SellerDashboardScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                ListTile(
                  leading: const Icon(Icons.pending, color: Colors.black,),
                  title: const Text(
                    "Pending",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>  PendingScreen()));
                  },
                ),
                Positioned(
                  child: Stack(
                    children: [
                      const Icon(
                        Icons.brightness_1,
                        size: 40.0,
                        color: Colors.red,
                      ),
                      Positioned(
                        child: Stack(
                          children: [
                            const Icon(
                              Icons.brightness_1,
                              size: 20.0,
                              color: Colors.redAccent,
                            ),
                            Positioned(
                              top: 3,
                              right: 4,
                              child: Center(
                                child: Consumer<CartItemCounter>(
                                  builder: (context, counter, c)
                                  {
                                    return Text(
                                      counter.count.toString(),
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.outdoor_grill, color: Colors.black,),
                  title: const Text(
                    "Confirm Pick Up",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>  NewOrdersScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.history, color: Colors.black,),
                  title: const Text(
                    "History",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>  HistoryScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.feedback, color: Colors.black,),
                  title: const Text(
                    "Feedbacks",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>  SellerDashboardScreen()));
                  },
                ),

                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.black,),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: ()
                  {
                    firebaseAuth.signOut().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
                    });
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

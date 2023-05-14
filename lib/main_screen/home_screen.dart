import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobileshop_admin_portal/authentication/login_screen.dart';
import 'package:mobileshop_admin_portal/riders/all_blocked_rider_screen.dart';
import 'package:mobileshop_admin_portal/riders/all_verified_rider_screen.dart';
import 'package:mobileshop_admin_portal/sellers/all_blocked_seller_screen.dart';
import 'package:mobileshop_admin_portal/sellers/all_verified_seller_screen.dart';
import 'package:mobileshop_admin_portal/users/all_blocked_user_screen.dart';
import 'package:mobileshop_admin_portal/users/all_verified_user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  String timeText = "";
  String dateText = "";


  String formatCurrentLiveTime(DateTime time)
  {
    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentDate(DateTime date)
  {
    return DateFormat("dd MMMM, yyyy").format(date);  //day,months,year
  }

  getCurrentLiveTime()
  {
    final DateTime timeNow = DateTime.now();  //get the current time
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentDate(timeNow);

    if(this.mounted)
    {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }
  @override
  void initState() {

    super.initState();
    //time
    timeText = formatCurrentLiveTime(DateTime.now());
    //date
    dateText = formatCurrentDate(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (timer)
    {
      getCurrentLiveTime();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors:
              [
                Colors.teal,
                Colors.white,
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(
          "Admin Web Portal",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(timeText + "\n" + dateText,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                letterSpacing: 2
              ),),
            ),
            //users activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_add, color: Colors.white,),
                  label: Text(
                    "All Verified Users".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(30),
                    primary: Colors.teal,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => AllVerifiedUserScreen()));
                  },
                ),

                const SizedBox(width: 20,),

                //block
                ElevatedButton.icon(
                  icon: const Icon(Icons.block_flipped, color: Colors.white,),
                  label: Text(
                    "All Blocked Users".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(30),
                    primary: Colors.blueAccent,
                  ),
                  onPressed: ()
                {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => AllBlockedUsersScreen()));
                  },
                ),
              ],
            ),
            SizedBox(height: 10,),

            //sellers activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_add, color: Colors.white,),
                  label: Text(
                    "All Verified Sellers".toUpperCase() +
                        "\n" + "Accounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(30),
                    primary: Colors.blueAccent,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => AllVerifiedSellerScreen()));
                  },
                ),

                const SizedBox(width: 20,),

                //block
                ElevatedButton.icon(
                  icon: const Icon(Icons.block_flipped, color: Colors.white,),
                  label: Text(
                    "All Blocked Sellers".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(30),
                    primary: Colors.teal,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => AllBlockedSellerScreen()));

                  },
                ),
              ],
            ),
            SizedBox(height: 10,),

            //riders activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_add, color: Colors.white,),
                  label: Text(
                    "All Verified Riders".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(30),
                    primary: Colors.teal,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => AllVerifiedRiderScreen()));
                  },
                ),

                const SizedBox(width: 20,),

                //block
                ElevatedButton.icon(
                  icon: const Icon(Icons.block_flipped, color: Colors.white,),
                  label: Text(
                    "All Blocked Riders".toUpperCase() + "\n" + "Accounts".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(30),
                    primary: Colors.blueAccent,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => AllBlockedRiderScreen()));
                  },
                ),
              ],
            ),
            SizedBox(height: 10,),

            //logout button
            ElevatedButton.icon(
              icon: const Icon(Icons.logout, color: Colors.white,),
              label: Text(
                "Logout".toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 3,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(30),
                primary: Colors.blue,
              ),
              onPressed: ()
              {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

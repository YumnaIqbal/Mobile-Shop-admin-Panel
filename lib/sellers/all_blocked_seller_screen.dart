import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobileshop_admin_portal/main_screen/home_screen.dart';
import 'package:mobileshop_admin_portal/widgets/simple_app_bar.dart';

class AllBlockedSellerScreen extends StatefulWidget {
  const AllBlockedSellerScreen({Key? key}) : super(key: key);

  @override
  State<AllBlockedSellerScreen> createState() => _AllBlockedSellerScreenState();
}

class _AllBlockedSellerScreenState extends State<AllBlockedSellerScreen> {
  QuerySnapshot? allSellers;

  displayDialogBoxForActivateAccount(userDocumentID)
  {
    return showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: const Text(
              "Activate Account",
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              "Do you want to activate this account ?",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: ()
                {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
              ElevatedButton(
                onPressed: ()
                {
                  Map<String, dynamic> userDataMap =
                  {
                    "status": "approved",
                  };

                  FirebaseFirestore.instance
                      .collection("sellers")
                      .doc(userDocumentID)
                      .update(userDataMap)
                      .then((value)
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));

                    SnackBar snackBar = const SnackBar(
                      content: Text(
                        "Activated Successfully.",
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.cyan,
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                child: const Text("Yes"),
              ),
            ],
          );
        }
    );
  }

  @override
  void initState() {  //first executed
    super.initState();

    FirebaseFirestore.instance
        .collection("sellers")
        .where("status", isEqualTo: "not approved")
        .get().then((allVerifiedUsers)   //give us the result of verified user
    {
      setState(() {
        allSellers = allVerifiedUsers;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget displayBlockedUserDesign(){
      if(allSellers != null){
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: allSellers!.docs.length,
          itemBuilder: (context, i)
          {
            return Card(
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(allSellers!.docs[i].get("sellerAvatarUrl")),
                              fit: BoxFit.fill,
                            )
                        ),
                      ),
                      title: Text(
                        allSellers!.docs[i].get("sellerName"),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.email, color: Colors.white,),
                          const SizedBox(width: 20,),
                          Text(
                            allSellers!.docs[i].get("sellerEmail"),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      icon:const Icon(
                        Icons.person_pin_sharp,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Total Earnings ".toUpperCase() + "Rs" + allSellers!.docs[i].get("earnings").toString(),
                        style:const TextStyle(
                            fontSize: 15,
                            letterSpacing: 3,
                            color: Colors.white
                        ),
                      ),
                      onPressed: (){
                       SnackBar snackBar = SnackBar(content: Text(
                         "Total Earnings ".toUpperCase() + "Rs" + allSellers!.docs[i].get("earnings").toString(),
                         style: TextStyle(
                           fontSize: 30,
                            color: Colors.white
                         ),
                       ),
                       backgroundColor: Colors.teal,
                       duration: Duration(seconds: 3),);
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                      ),
                      icon:const Icon(
                        Icons.person_pin_sharp,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Activate This Account".toUpperCase(),
                        style:const TextStyle(
                            fontSize: 15,
                            letterSpacing: 3,
                            color: Colors.white
                        ),
                      ),
                      onPressed: (){
                        displayDialogBoxForActivateAccount(allSellers!.docs[i].id);
                      },
                    ),
                  )

                ],
              ),
            );
          },

        );
      }
      else{
        return const Center(
          child: Text(
            "No Record Found",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        );
      }
    }
    return Scaffold(
      appBar: SimpleAppBar(title: "All Blocked Sellers Accounts",),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width *.5,
          child: displayBlockedUserDesign(),
        ),
      ),
    );
  }
}

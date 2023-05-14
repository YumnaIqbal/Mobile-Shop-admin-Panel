import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobileshop_admin_portal/main_screen/home_screen.dart';
import 'package:mobileshop_admin_portal/widgets/simple_app_bar.dart';

class AllVerifiedRiderScreen extends StatefulWidget {
  const AllVerifiedRiderScreen({Key? key}) : super(key: key);

  @override
  State<AllVerifiedRiderScreen> createState() => _AllVerifiedRiderScreenState();
}

class _AllVerifiedRiderScreenState extends State<AllVerifiedRiderScreen> {
  QuerySnapshot? allRiders;

  displayDialogBoxForBlockingAccount(userDocumentID)
  {
    return showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: const Text(
              "Block Account",
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              "Do you want to block this account ?",
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
                    "status": "not approved",
                  };

                  FirebaseFirestore.instance
                      .collection("riders")
                      .doc(userDocumentID)
                      .update(userDataMap)
                      .then((value)
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));

                    SnackBar snackBar = const SnackBar(
                      content: Text(
                        "Blocked Successfully.",
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
        .collection("riders")
        .where("status", isEqualTo: "approved")
        .get().then((allVerifiedRiders)   //give us the result of verified user
    {
      setState(() {
        allRiders = allVerifiedRiders;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget displayVerifiedRiderDesign(){
      if(allRiders != null){
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: allRiders!.docs.length,
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
                              image: NetworkImage(allRiders!.docs[i].get("riderAvatarUrl")),
                              fit: BoxFit.fill,
                            )
                        ),
                      ),
                      title: Text(
                        allRiders!.docs[i].get("riderName"),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.email, color: Colors.white,),
                          const SizedBox(width: 20,),
                          Text(
                            allRiders!.docs[i].get("riderEmail"),
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
                        "Total Earnings ".toUpperCase() + "Rs" + allRiders!.docs[i].get("earnings").toString(),
                        style:const TextStyle(
                            fontSize: 15,
                            letterSpacing: 3,
                            color: Colors.white
                        ),
                      ),
                      onPressed: (){
                        SnackBar snackBar = SnackBar(content: Text(
                          "Total Earnings ".toUpperCase() + "Rs" + allRiders!.docs[i].get("earnings").toString(),
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white
                          ),
                        ),
                          backgroundColor: Colors.cyan,
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
                        "Blocked This Account".toUpperCase(),
                        style:const TextStyle(
                            fontSize: 15,
                            letterSpacing: 3,
                            color: Colors.white
                        ),
                      ),
                      onPressed: (){
                        displayDialogBoxForBlockingAccount(allRiders!.docs[i].id);
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
      appBar: SimpleAppBar(title: "All Verified Riders Accounts",),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width *.5,
          child: displayVerifiedRiderDesign(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Center(child: Text("Student Details", style: TextStyle(color: Colors.white))),
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        body: ListView(
          children: [
            //Name
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green[100],
              ),
              child: Center(child: Text("Name: Manoj Anaparthi", style: TextStyle(fontSize: 20))),
            ),
            //Roll no
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green[200],
              ),
              child: Center(child: Text("Roll no: 23110025", style: TextStyle(fontSize: 20))),
            ),
            //Batch
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green[300],
              ),
              child: Center(child: Text("Batch: 2023", style: TextStyle(fontSize: 20))),
            ),
            //Discipline
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green[400],
              ),
              child: Center(child: Text("Discipline: CSE", style: TextStyle(fontSize: 20))),
            ),
            //Hostel
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green[500],
              ),
              child: Center(child: Text("Hostel: Hiqom", style: TextStyle(fontSize: 20))),
            ),
            //Contact
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green[600],
              ),
              child: Center(child: Text("Contact: 9876543210", style: TextStyle(fontSize: 20))),
            ),
          ],
        ),
      );
  }
}
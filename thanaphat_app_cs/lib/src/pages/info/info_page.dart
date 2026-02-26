import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Info')),
      body: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 70,
            // backgroundImage: NetworkImage(
            //   'https://i.pinimg.com/originals/19/18/fe/1918feecc8c21fd31ee0d11067f1e534.jpg',
            // ),
            backgroundImage: AssetImage('assets/images/Profile.jpg'),
          ),
          Text(
            'Thanaphat Suwancharoen',
            style: TextStyle(fontFamily: 'Mitr', fontSize: 28),
          ),
          Text(
            'STUDENT',
            style: TextStyle(
              fontFamily: 'Kanit',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
            width: 290,
            child: Divider(color: Colors.teal, thickness: 3),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            color: Colors.black12,
            child: Row(
              children: [
                Icon(Icons.person, color: Colors.teal),
                Text(
                  'Name: \tThanaphat Suwancharoen',
                  style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            color: Colors.black12,
            child: Row(
              children: [
                Icon(Icons.book_rounded, color: Colors.teal),
                Text(
                  'Major: \tComputer Science',
                  style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            color: Colors.black12,
            child: Row(
              children: [
                Icon(Icons.email, color: Colors.teal),
                Text(
                  'Email: \t664234011@parichat.skru.ac.th',
                  style: TextStyle(fontFamily: 'Kanit', fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

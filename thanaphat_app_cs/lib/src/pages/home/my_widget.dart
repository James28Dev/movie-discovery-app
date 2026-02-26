import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thanaphat_app_cs/src/pages/config/app_route.dart';

class MyWidget extends StatelessWidget {
  MyWidget({super.key});

  final List<String> images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://drive.google.com/uc?id=1lgEVj5HAg291Ba7EZyrvjMNtjSL4lpIq',
    'https://drive.google.com/uc?id=1yPzOxnKj0_dR1sgmvybN0ZJ49scCv1r5',
    'https://drive.google.com/uc?id=1znbomnyyGoY5ual27rMypuH2c4i6rBRQ',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.infoRoute);
            },
            icon: Icon(Icons.notification_add, color: Colors.orange),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.orange),
          ),
        ],
        title: Text('My Widget'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'All Widgets',
              style: TextStyle(
                fontFamily: 'Mitr',
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.upcomingMovieRoute);
                  },
                  child: buildContainer('Movie', 'assets/images/cinema.png'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.myWidgetRoute);
                  },
                  child: buildContainer('New', 'assets/images/newspaper.png'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.myWidgetRoute);
                  },
                  child: buildContainer('Map', 'assets/images/map.png'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/cinema.png'),
                ),
                title: Text(
                  'Comming soon',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('see more details...'),
                trailing: Icon(Icons.more, color: Colors.pink),
                tileColor: Colors.blueGrey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Slidable(
                // เลื่อนทางซ้าย
                startActionPane: ActionPane(
                  motion: DrawerMotion(),
                  children: [
                    SlidableAction(
                      icon: Icons.remove_red_eye,
                      label: 'View',
                      backgroundColor: Colors.orange.shade200,
                      onPressed: (context) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Click and view')),
                        );
                        Navigator.pushNamed(context, AppRoute.infoRoute);
                      },
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: StretchMotion(),
                  children: [
                    SlidableAction(
                      icon: Icons.delete,
                      label: 'Delete',
                      backgroundColor: Colors.red,
                      onPressed: (context) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Click and view')),
                        );
                        Navigator.pushNamed(context, AppRoute.infoRoute);
                      },
                    ),
                    SlidableAction(
                      icon: Icons.share,
                      label: 'Share',
                      backgroundColor: Colors.greenAccent,
                      onPressed: (context) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Click and view')),
                        );
                        Navigator.pushNamed(context, AppRoute.infoRoute);
                      },
                    ),
                  ],
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/pin_biker.png'),
                  ),
                  title: Text(
                    'Slidable',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('see more details...'),
                  trailing: Icon(Icons.more, color: Colors.pink),
                  tileColor: Colors.blueGrey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.green.shade200,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/leaf.jpg'),
                    ),
                    Text(
                      '\t\tLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'
                      's standard dummy text ever since the 1500s',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.lightGreenAccent.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ExpansionTile(
                  title: Text(
                    'หัวข้อ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('ย่อ/ขยาย'),
                  children: [
                    Image(
                      image: AssetImage('assets/images/Profile.jpg'),
                      width: 150,
                      height: 150,
                    ),
                    Text(
                      'There are many variations of passages of Lorem Ipsum available',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {}, child: Text('Share')),
                        TextButton(onPressed: () {}, child: Text('Like')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CarouselSlider.builder(
              itemCount: images.length,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              itemBuilder: (context, index, realIdx) {
                return Center(
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    width: 1000,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer(String name, String imgPath) {
    return Container(
      decoration: ShapeDecoration(
        image: DecorationImage(scale: 8, image: AssetImage(imgPath)),
        color: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      width: 90,
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

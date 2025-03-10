import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/views/pages/home_page.dart';
import 'package:water_reminder/views/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic>? userData;
  ProfilePage({super.key, this.userData});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          //sola home ikonu
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Get.to(Home());
          },
        ),
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white), //sağa logout ikonu
            onPressed: () {
              userController.logout();
              Get.offAll(LoginPage());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (userController.userData.isEmpty) {
          return Center(child: Text("Kullanıcı bilgileri bulunamadı!"));
        }

        return Padding(
          padding: EdgeInsets.all(26),

          child: Container(
            width: double.infinity,
            height: context.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      '${userController.userData['image']}',
                    ), // API model image link
                  ),
                ),
                SizedBox(height: 12),

                Text(
                  "${userController.userData['firstName']} ${userController.userData['lastName']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '${userController.userData['email']}',
                  style: TextStyle(
                    color: Color.fromARGB(255, 99, 98, 98),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '${userController.userData['gender']}',
                  style: TextStyle(
                    color: Color.fromARGB(255, 99, 98, 98),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }
}

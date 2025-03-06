import 'package:flutter/material.dart';
import 'package:water_reminder/models/api_model.dart';
import 'package:water_reminder/services/api_services.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
    /*
    return FutureBuilder<ApiModel>(
      future: apiCall(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          debugPrint("API Hatası: ${snapshot.error}");

          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Veri bulunamadı.'));
        }

        final apiData = snapshot.data!;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage:
                    apiData.image != null && apiData.image!.isNotEmpty
                        ? NetworkImage(apiData.image!)
                        : NetworkImage('https://via.placeholder.com/150'),
              ),
              SizedBox(height: 12),
              Text(
                "Name: ${apiData.firstName + apiData.lastName}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),

              Text(
                "E-Posta: ${apiData.email}", // E-posta adresi
                style: TextStyle(
                  color: Color.fromARGB(255, 99, 98, 98),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),

              Text(
                "Gender: ${apiData.gender}",
                style: TextStyle(
                  color: Color.fromARGB(255, 99, 98, 98),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    /*
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          const SizedBox(height: 12),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'johndoe@example.com',
            style: TextStyle(
              color: Color.fromARGB(255, 99, 98, 98),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Bugüne kadar içilen toplam su miktar:',
            style: TextStyle(
              color: Color.fromARGB(255, 99, 98, 98),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
    */
    */
  }
}

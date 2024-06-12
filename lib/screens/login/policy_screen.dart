import 'package:flutter/material.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Privacy & Policy",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Text(
                  'This privacy policy applies to the Mr Melawi app (hereby referred to as "Application") for mobile devices that was created by CV Solusi Komputer (hereby referred to as "Service Provider") as a Free service. This service is intended for use "AS IS".',
                  textAlign: TextAlign.justify,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      "Information Collection and Use",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                Text(
                  'The Application collects information when you download and use it. This information may include information such as',
                  textAlign: TextAlign.justify,
                ),
                Text(
                  '1.Your devices Internet Protocol address (e.g. IP address) ',
                  textAlign: TextAlign.justify,
                ),
                Text(
                  '2.The pages of the Application that you visit, the time and date of your visit, the time spent on those pages',
                  textAlign: TextAlign.justify,
                ),
                Text(
                  '3.The operating system you use on your mobile device',
                  textAlign: TextAlign.justify,
                ),
                Text(
                  'The Application does not gather precise information about the location of your mobile device.The Service Provider may use the information you provided to contact you from time to time to provide you with important information, required notices and marketing promotions. For a better experience, while using the Application, the Service Provider may require you to provide us with certain personally identifiable information, including but not limited to cv.solusikomputer@gmail.com. The information that the Service Provider request will be retained by them and used as described in this privacy policy.',
                  textAlign: TextAlign.justify,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      "Third Party Acces",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                Text(
                  'Only aggregated, anonymized data is periodically transmitted to external services to aid the Service Provider in improving the Application and their service. The Service Provider may share your information with third parties in the ways that are described in this privacy statement.',
                  textAlign: TextAlign.justify,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      "Opt-Out Rights",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                Text(
                  'You can stop all collection of information by the Application easily by uninstalling it. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network.',
                  textAlign: TextAlign.justify,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      "Data Retention Policy",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                Text(
                  'The Service Provider will retain User Provided data for as long as you use the Application and for a reasonable time thereafter. If youd like them to delete User Provided Data that you have provided via the Application, please contact them at cv.solusikomputer@gmail.com and they will respond in a reasonable time.',
                  textAlign: TextAlign.justify,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      "Children",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                Text(
                  'The Service Provider does not use the Application to knowingly solicit data from or market to children under the age of 13.The Application does not address anyone under the age of 13. The Service Provider does not knowingly collect personally identifiable information from children under 13 years of age. In the case the Service Provider discover that a child under 13 has provided personal information, the Service Provider will immediately delete this from their servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact the Service Provider (cv.solusikomputer@gmail.com) so that they will be able to take the necessary actions.',
                  textAlign: TextAlign.justify,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      "Contact Us",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                Text(
                  'If you have any questions regarding privacy while using the Application, or have questions about the practices, please contact the Service Provider via email at cv.solusikomputer@gmail.com.',
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

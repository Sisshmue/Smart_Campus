import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Get In touch",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffD9D9D9),
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 130,
                backgroundImage: NetworkImage(
                    'https://lms.mfu.ac.th/pluginfile.php/1/theme_space/logosimage4/1723404636/%E0%B8%AA%E0%B8%B3%E0%B8%AB%E0%B8%A3%E0%B8%B1%E0%B8%9A%E0%B8%AA%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B9%82%E0%B8%8B%E0%B9%80%E0%B8%8A%E0%B8%B5%E0%B8%A2%E0%B8%A5%E0%B8%A1%E0%B8%B5%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2.png'),
              ),
            ),
            height: 350,
            width: 471,
            decoration: const BoxDecoration(
                color: Color(0xffD9D9D9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                  bottomRight: Radius.circular(200),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Mae Fah Luang University",
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '333, Moo1, Thasud, 57100, \n Mueang, Chiang Rai, Thailand \nFax-0-2679-0038-9\nTel. 0-2679-0038, 0-5391-6000, 0-5391-7034',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.facebook,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.call,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mail,
                      size: 30,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

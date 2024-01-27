import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final newsViewModel = NewsViewModel();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              "images/category_icon.png",
              width: 30,
              height: 30,
            )),
        title: Text(
          "News",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 24),
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder(
            future: newsViewModel.fetchNewsHeadlines(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SpinKitFadingCircle(
                  size: 50,
                  color: Colors.pink,
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: const Stack(
                        alignment: Alignment.center,
                      ),
                    );
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}

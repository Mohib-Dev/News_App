import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatefulWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;

  const NewsScreen(
      {super.key,
      required this.newsImage,
      required this.newsTitle,
      required this.newsDate,
      required this.author,
      required this.description,
      required this.content,
      required this.source});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final format = DateFormat("MMMM dd,yyyy");
    final dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            SizedBox(
              height: height * 0.45,
              child: ClipRRect(
                  child: CachedNetworkImage(
                imageUrl: widget.newsImage,
                fit: BoxFit.cover,
                placeholder: ((context, url) => const Center(
                      child: CircularProgressIndicator(),
                    )),
              )),
            ),
            Container(
              height: height * 0.6,
              margin: EdgeInsets.only(top: height * 0.4),
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: const BoxDecoration(color: Colors.white),
              child: ListView(
                children: [
                  Text(
                    widget.newsTitle,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.source,
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        format.format(dateTime),
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    widget.description,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

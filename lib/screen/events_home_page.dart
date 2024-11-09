import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'event_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://ev.runlah.com/api/1/images/e-yFrfl7WiZh-banner.jpg?size=xl',
  'https://cdn-az.allevents.in/events8/banners/6d70a70763c06992766e3c8ab3671cd45ee4ab201775a1542297f4aa0cc6b5b4-rimg-w1200-h628-dcff6200-gmir?v=1730695638',
  'https://en.mfu.ac.th/fileadmin/mainsite_news_eng/news/2024/World_Ranking_2025_2-01.png',
];

class EventsHomePage extends StatefulWidget {
  const EventsHomePage({super.key});

  @override
  State<EventsHomePage> createState() => _EventsHomePageState();
}

class _EventsHomePageState extends State<EventsHomePage> {
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  int _currentIndex = 0;
  bool isSearching = false;

  final List<Widget> imageSliders = imgList
      .map(
        (item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        'No. ${imgList.indexOf(item)} image',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events and News",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF6597E1),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          // Search Bar

          Column(
            children: [
              Container(
                height: 41,
                width: 235,
                margin: EdgeInsets.all(8.0),
                child: Card(
                  color: Color(0xFFD9D9D9),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: Icon(
                          // searchQuery.isEmpty &&
                          isSearching ? Icons.clear : Icons.search,
                        ),
                        onPressed: () {
                          if (isSearching) {
                            FocusScope.of(context).unfocus();
                            // Clear the search query and reset search state
                            _searchController.clear();
                            setState(() {
                              searchQuery = ""; // Clear search query
                              isSearching = false; // Switch back to search icon
                            });
                          }
                        },
                      ),
                      border: InputBorder.none,
                    ),
                    onTap: () {
                      setState(() {
                        isSearching = true; // Activate search mode
                      });
                    },
                    onChanged: (val) {
                      setState(() {
                        searchQuery = val; // Update the search query
                      });
                    },
                  ),
                ),
              ),
            ],
          ),

          if (isSearching) ...[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('events').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF6597E1),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final events = snapshot.data!.docs;

                  // Filter events based on the search query
                  final filteredEvents = events.where((event) {
                    var data = event.data() as Map<String, dynamic>;
                    return data['name']
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase());
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      var data =
                          filteredEvents[index].data() as Map<String, dynamic>;
                      String imageUrl =
                          data['img'] ?? ''; // Use a default value if null
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Event(
                                  name: data['name'],
                                  about: data['about'],
                                  isDone: data['isDone'],
                                  detail: data['detail'],
                                  img: data['img'],
                                  img2: data['img2'],
                                  hasButton: data['hasButton'],
                                ),
                              ));
                        },
                        title: Text(
                          data['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: imageUrl.isNotEmpty
                              ? NetworkImage(imageUrl)
                              : const NetworkImage(
                                  'https://www.stsbeijing.org/wp-content/uploads/2022/05/ThaiUni4.png'), // Use a placeholder image
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ] else ...[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Carousel Slider
                    CarouselSlider(
                      items: imageSliders,
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _currentIndex = entry.key),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: _currentIndex == entry.key ? 50 : 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              color: _currentIndex == entry.key
                                  ? Colors.blueAccent
                                  : Colors.grey,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(
                                  _currentIndex == entry.key ? 10 : 50),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),
                    // StreamBuilder for Firestore
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection('events')
                            .orderBy('createBy', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF6597E1),
                              ),
                            );
                          }
                          final events = snapshot.data?.docs;
                          List<EventBubble> eventsWidgets = [];
                          for (var event in events!) {
                            final eventName = event.get('name');
                            final eventAbout = event.get('about');
                            final isDone = event.get('isDone');
                            final eventDetail = event.get('detail');
                            final eventImages = event.get('img');
                            final eventImages2 = event.get('img2');
                            final hasButton = event.get('hasButton');

                            final eventsWidget = EventBubble(
                              name: eventName,
                              about: eventAbout,
                              isDone: isDone,
                              detail: eventDetail,
                              img: eventImages,
                              img2: eventImages2,
                              hasButton: hasButton,
                            );

                            eventsWidgets.add(eventsWidget);
                          }
                          return ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: eventsWidgets,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class EventBubble extends StatelessWidget {
  const EventBubble({
    super.key,
    required this.name,
    required this.about,
    required this.isDone,
    required this.detail,
    required this.img,
    required this.img2,
    required this.hasButton,
  });

  final String name;
  final String about;
  final bool isDone;
  final String detail;
  final String img;
  final String img2;
  final bool hasButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
      child: GestureDetector(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  child: img.isNotEmpty
                      ? Image.network(img)
                      : Image.network(
                          'https://www.stsbeijing.org/wp-content/uploads/2022/05/ThaiUni4.png'),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Text(about),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Event(
                name: name,
                about: about,
                isDone: isDone,
                detail: detail,
                img: img,
                img2: img2,
                hasButton: hasButton,
              ),
            ),
          );
        },
      ),
    );
  }
}

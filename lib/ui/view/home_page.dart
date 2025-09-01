import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/blocs/emergency/emergency_campaigns_bloc.dart';
import 'package:hello/blocs/emergency/emergency_campaigns_event.dart';
import 'package:hello/blocs/emergency/emergency_campaigns_state.dart';
import 'package:hello/blocs/search/search_bloc.dart';
import 'package:hello/blocs/search/search_event.dart';
import 'package:hello/blocs/search/search_state.dart';
import 'package:hello/blocs/statistics/bloc.dart';
import 'package:hello/blocs/statistics/event.dart';
import 'package:hello/blocs/statistics/state.dart';
import 'package:hello/core/color.dart';
import 'package:hello/models/search.dart';
import 'package:hello/services/emergency_campaigns_service.dart';
import 'package:hello/services/search_service.dart';
import 'package:hello/services/statistics_home_service.dart';
import 'package:hello/ui/view/volunteer_page.dart';
import 'package:hello/widgets/NavBar.dart';
import 'package:hello/widgets/QuickDonateButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ========== Search Delegate ==========

class SimpleSearchDelegate extends SearchDelegate<String> {
  final SearchBloc searchBloc;

  SimpleSearchDelegate({required this.searchBloc});

  // ✅ دالة تجيب التوكن من SharedPreferences
  // Future<String?> _getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("token");
  // }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.green),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.green),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // if (query.isNotEmpty) {
    //   print("🔍 Searching for: $query");

    //   _getToken().then((token) {
    //     if (token != null) {
    //       searchBloc.add(SearchCampaignsEvent(query, token)); // ✅ صححناها
    //     } else {
    //       print("❌ No token found");
    //     }
    //   });
    // }

    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.green));
        } else if (state is SearchLoaded) {
          final results = state.campaigns;
          if (results.isEmpty) {
            return const Center(child: Text("لا توجد نتائج"));
          }
          return ListView.separated(
            itemCount: results.length,
            separatorBuilder: (_, __) =>
                const Divider(color: Colors.green),
            itemBuilder: (context, index) {
              final Campaign campaign = results[index];
              return ListTile(
                leading: Image.network(
                  campaign.photo,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  campaign.title,
                  style: const TextStyle(color: Colors.green),
                ),
                subtitle: Text("المبلغ المطلوب: ${campaign.amountRequired}"), // ✅ عدلناها
                onTap: () {
                  close(context, campaign.title);
                },
              );
            },
          );
        } else if (state is SearchError) {
          return Center(
              child: Text("خطأ: ${state.message}",
                  style: const TextStyle(color: Colors.red)));
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "اكتب اسم الحملة للبحث...",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
// ========== Home Page ==========

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ValueNotifier<int> floatingStateNotifier = ValueNotifier<int>(0);
final SearchService searchService = SearchService(); // هذا فقط لتعريف الـ Bloc
  late final SearchBloc searchBloc = SearchBloc(searchService);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: searchBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          bottomNavigationBar: BottomNavBar(currentIndex: 0, onTap: (index) {}),
          floatingActionButton: const GlobalDonationFab(),
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: babygreen,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.search, color: medium_Green),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: SimpleSearchDelegate(searchBloc: searchBloc),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'تراحم',
                      style: TextStyle(
                        color: medium_Green,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Zain',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // ===== Carousel Slider =====
              CarouselSlider(
                items: [
                  buildCarouselItem(
                    'assets/images/slider1.jpg',
                    'لَن تَنَالُوا الْبِرَّ حَتَّى تُنفِقُوا مِمَّا تُحِبُّونَ',
                  ),
                  buildCarouselItem(
                    'assets/images/slider1.jpg',
                    'وَمَا تُقَدِّمُوا لِأَنفُسِكُم مِّنْ خَيْرٍ تَجِدُوهُ عِندَ اللَّهِ',
                  ),
                  buildCarouselItem(
                    'assets/images/slider1.jpg',
                    'مَّن ذَا الَّذِي يُقْرِضُ اللَّهَ قَرْضًا حَسَنًا فَيُضَاعِفَهُ لَهُ أَضْعَافًا كَثِيرَةً ۚ وَاللَّهُ يَقْبِضُ وَيَبْسُطُ وَإِلَيْهِ تُرْجَعُونَ',
                  ),
                  buildCarouselItem(
                    'assets/images/slider1.jpg',
                    'الذِينَ يُنفِقُونَ أَمْوَالَهُم بِاللَّيْلِ وَالنَّهَارِ سِرًّا وَعَلَانِيَةً فَلَهُمْ أَجْرُهُمْ عِندَ رَبِّهِمْ وَلَا خَوْفٌ عَلَيْهِمْ وَلَا هُمْ يَحْزَنُونَ',
                  ),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.5,
                ),
              ),

              const SizedBox(height: 20),

              // ===== الأقسام =====
              Text(
                'الأقسام',
                style: TextStyle(
                  color: zeti,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Zain',
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    sectionCard(
                      context,
                      'الحملات',
                      Icons.campaign,
                      DummyPage('الحملات'),
                    ),
                    sectionCard(
                      context,
                      'التبرع العيني',
                      Icons.volunteer_activism,
                      DummyPage('التبرع العيني'),
                    ),
                  
                    sectionCard(
                      context,
                      'قسم التطوع',
                      Icons.groups,
                      VolunteerCampaignsPage(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ===== الحالات الطارئة =====
              Text(
                'الحالات الطارئة',
                style: TextStyle(
                  color: zeti,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Zain',
                ),
              ),
              const SizedBox(height: 10),
              BlocProvider(
                create:
                    (_) =>
                        EmergencyCampaignsBloc(EmergencyCampaignsService())
                          ..add(FetchEmergencyCampaignsEvent()),
                child: BlocBuilder<
                  EmergencyCampaignsBloc,
                  EmergencyCampaignsState
                >(
                  builder: (context, state) {
                    if (state is EmergencyCampaignsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is EmergencyCampaignsLoaded) {
                      final campaigns = state.campaigns;
                      if (campaigns.isEmpty) {
                        return const Text('لا توجد حالات طارئة حالياً');
                      }
                      return SizedBox(
                        height: 350,
                        child: Directionality(
                            textDirection: TextDirection.rtl,

                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            // reverse: true,
                            itemCount: campaigns.length,
                            separatorBuilder:
                                (context, index) => const SizedBox(width: 16),
                            itemBuilder: (context, index) {
                              final c = campaigns[index];
                              return buildEmergencyCard(
                                title: c.title,
                                imageUrl: c.photo, 
                                location: c.location,
                                money:
                                    c.donationAmount
                                        .round(), 
                                days:
                                    c.amountToComplete
                                        .toString(),
                                        type: c.type // مطلوب بالتوقيع فقط
                              );
                            },
                          ),
                        ),
                      );
                    } else if (state is EmergencyCampaignsError) {
                      return Text(
                        'خطأ: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),

              const SizedBox(height: 16),

              // ===== الإحصائيات =====
              Text(
                'الإحصائيات',
                style: TextStyle(
                  color: zeti,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Zain',
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: BlocProvider(
                      create:
                          (_) =>
                              EndedCampaignsBloc(EndedCampaignsService())
                                ..add(FetchEndedCampaignsEvent()),
                      child:
                          BlocBuilder<EndedCampaignsBloc, EndedCampaignsState>(
                            builder: (context, endedState) {
                              if (endedState is EndedCampaignsLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (endedState is EndedCampaignsLoaded) {
                                return buildStatBox(
                                  'عدد المستفيدين',
                                  endedState.totalEnded.toString(),
                                );
                              } else if (endedState is EndedCampaignsError) {
                                return Text(
                                  'خطأ: ${endedState.message}',
                                  style: const TextStyle(color: Colors.red),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BlocProvider(
                      create:
                          (_) =>
                              StatisticsBloc(StatisticsService())
                                ..add(FetchAssociationCountEvent()),
                      child: BlocBuilder<StatisticsBloc, StatisticsState>(
                        builder: (context, statsState) {
                          if (statsState is StatisticsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (statsState is StatisticsLoaded &&
                              statsState.count.data != null) {
                            return buildStatBox(
                              'عدد الجمعيات',
                              statsState.count.data.toString(),
                            );
                          } else if (statsState is StatisticsError) {
                            return Text(
                              'خطأ: ${statsState.message}',
                              style: const TextStyle(color: Colors.red),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: BlocProvider(
                      create:
                          (_) =>
                              DonationBloc(DonationService())
                                ..add(FetchDonationTotalEvent()),
                      child: BlocBuilder<DonationBloc, DonationState>(
                        builder: (context, donationState) {
                          if (donationState is DonationLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (donationState is DonationLoaded) {
                            return buildStatBox(
                              'إجمالي التبرعات',
                              donationState.donation.total.toString(),
                            );
                          } else if (donationState is DonationError) {
                            return Text(
                              'خطأ: ${donationState.message}',
                              style: const TextStyle(color: Colors.red),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
  child: BlocProvider(
                      create:
                          (_) =>
                              InKindBloc(InKindService())
                                ..add(FetchInkindEvent()),
                      child: BlocBuilder<InKindBloc, InKindDonationState>(
                        builder: (context, donationState) {
                          if (donationState is InKindDonationLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (donationState is InKindDonationLoaded) {
                            return buildStatBox(
                              ' التبرعات العينية',
                              donationState.donation.data.toString(),
                            );
                          } else if (donationState is InKindDonationError) {
                            return Text(
                              'خطأ: ${donationState.message}',
                              style: const TextStyle(color: Colors.red),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
     )
    );
  }
}

class DummyPage extends StatelessWidget {
  final String title;
  const DummyPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          'صفحة $title',
          style: TextStyle(fontSize: 30, fontFamily: 'Zain'),
        ),
      ),
    );
  }
}

Widget buildCarouselItem(String imagePath, String text) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: zeti.withOpacity(0.5),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              // fontFamily: 'Zain',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}

Widget buildEmergencyCard({
  required String title,
  required String imageUrl,
  //required String imagePath,
  required String location,
  required int money,
  required String days,
    required String type,
}) {
  final ImageProvider imgProvider =
      imageUrl.startsWith('http')
          ? NetworkImage(imageUrl)
          : AssetImage(imageUrl) as ImageProvider;

  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 360,
          width: 320,
          decoration: BoxDecoration(
            // border: Border.all(color: medium_Green,),
            borderRadius: BorderRadius.circular(40),
            image: DecorationImage(image: imgProvider, fit: BoxFit.cover),
            // boxShadow: [
            //   BoxShadow(
            //     color: zeti.withOpacity(0.4),
            //     blurRadius: 4,
            //     offset: Offset(10, 2),
            //   ),
            // ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 350,
          width: 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.1),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0XFFF2F4EC),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Zain',
                        ),
                        maxLines: null, 
                        overflow: TextOverflow.ellipsis, 
                        softWrap: true, 
                      ),
                          SizedBox(height: 4),
          Text(
        type,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white70,
          fontWeight: FontWeight.w400,
          fontFamily: 'Zain',
        ),
            ),
                ],
                  ),
                
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, color: Color(0xFFb3beb0), size: 16),
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFFF2F4EC),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Zain',
                        ),
                         maxLines: null, 
                        overflow: TextOverflow.ellipsis, 
                        softWrap: true,
                      ),
                      const SizedBox(width: 25),
                      Icon(Icons.money, color: Color(0xFFb3beb0), size: 16),
                      const SizedBox(width: 5),
                      Text(
                        money.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0XFFF2F4EC),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Zain',
                        ),
                      ),
                    ],
                  ),
                  trailing: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(150),
                      borderRadius: BorderRadius.circular(25),
                    ),
        
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
        
                        backgroundColor: Light_Green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
        
                      child: Text(
                        'تبرع',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Zain',
                          fontWeight: FontWeight.w600,
                          color: zeti,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget sectionCard(
  BuildContext context,
  String title,
  IconData iconData,
  Widget targetPage,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      children: [
        Material(
          color: babygreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: medium_Green),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            splashColor: white.withOpacity(0.3),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => targetPage),
              );
            },

            child: Container(
              width: 80,
              height: 80,
              child: Center(child: Icon(iconData, color: zeti, size: 30)),
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            title,
            style: TextStyle(
              color: zeti,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Zain',
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget buildStatBox(String title, String value) {
  return Container(
    decoration: BoxDecoration(
      color: babygreen,
      borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: zeti,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Zain',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: Color.fromARGB(255, 247, 119, 134),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Zain',
          ),
        ),
      ],
    ),
  );
}

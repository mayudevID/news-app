import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_app/login/firebase_authentication.dart';
import 'package:news_app/pages/news_detail_page.dart';
import 'package:news_app/services/services.dart';
import 'package:shimmer/shimmer.dart';

class ListNewsPage extends ConsumerWidget {
  const ListNewsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(newsDataProvider);

    Widget shimmerData() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(12),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text(
          "Berita - Indonesia",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            tooltip: 'Logout',
            onPressed: () async {
              signOut(context);
            },
          ),
        ],
      ),
      body: data.when(
        data: (data) {
          return ListView.separated(
            itemBuilder: (_, idx) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return NewsDetailPage(newsModelDatum: data.data[idx]);
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(18),
                  margin: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: (idx == 0) ? 12 : 0,
                    bottom: (idx == data.data.length - 1) ? 12 : 0,
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        width: 100,
                        fit: BoxFit.cover,
                        data.data[idx].image ??
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnM0bTpj8lQUZ1VzOZPy_xAPEFwbSjGU50c8g_elo0Bw&s",
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              data.data[idx].title ?? "No Title",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy HH:mm').format(
                                data.data[idx].isoDate ??
                                    DateTime.parse("2024-05-08T00:14:37.000Z"),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, idx) {
              return const SizedBox(
                height: 12,
              );
            },
            itemCount: data.data.length,
          );
        },
        error: (err, s) {
          return Text(s.toString());
        },
        loading: () => Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: Column(
            children: [
              shimmerData(),
              shimmerData(),
              shimmerData(),
              shimmerData(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mlaku_mlaku/features/data/datasources/firebase/cloud_service.dart';
import 'package:mlaku_mlaku/features/domain/entities/hotels_ent.dart';
import 'package:mlaku_mlaku/features/presentation/bloc/booking/booking_hotels_bloc.dart';

import '../../../../injection_container.dart';
import '../../widgets/hotels_rating_widget.dart';

class BookingPage extends StatelessWidget {
   BookingPage({super.key});

CloudService db = sl();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved'),
      ),
      body: StreamBuilder(
        stream: db.getAllReservation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot<Object?>> userList =
                  snapshot.data!.docs;
              var doc = snapshot.data!;
              return GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width,
                  mainAxisExtent: 265,
                  mainAxisSpacing: 16,
                ),
                itemCount: userList.length,
                // itemCount: 0,
                itemBuilder: (context, index) {
                  DocumentSnapshot docSnap = userList[index];
                  HotelsEntity hm = HotelsEntity.fromDocumentSnapshot(docSnap);
                  return InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, '/LHPage', arguments: bookedHotels[index]);
                    },
                    child: GridTile(
                      child: Container(
                        child: Image.network(
                          hm.image!,
                          // '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      footer: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _title(hm),
                            SizedBox(
                              height: 8,
                            ),
                            // LabelNStarWidget(countStar: hm.star),
                            SizedBox(
                              height: 8,
                            ),
                            // LocationNDistance(location: hm.location),
                            Divider(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(hm.getPrice),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('kosong'));
            }
          }
        },
      ),
    );
  }

  Row _title(HotelsEntity hm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // mainAxisSize: MainAxisSize.max,
      children: [
        Text('${hm.name}'),
        HotelsRating(
          rating: hm.rating ?? 0.0,
        )
      ],
    );
  }
}

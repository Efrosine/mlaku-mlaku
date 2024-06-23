// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mlaku_mlaku/features/data/datasources/firebase/cloud_service.dart';
import 'package:mlaku_mlaku/injection_container.dart';

import '../../widgets/additional_feature_widget.dart';
import '../../widgets/main_feature_widget.dart';
import '../../widgets/promo_widget.dart';
import '../../widgets/sugestion_hotels_widget.dart';
import '../../widgets/wallet_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  CloudService db = sl();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _body(context),
        // extendBodyBehindAppBar: true,
      ),
    );
  }

  _appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: StreamBuilder(
            stream: db.getDataUser(),
            builder: (context, snapshot) {
              return Text('Hi, ${snapshot.data?['name'] ?? 'User'}');
            }),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_outlined,
              )),
        ],
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
    );
  }

  _body(BuildContext context) {
    return ListView(
      children: [
        Stack(
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            SizedBox(height: 90),
            Container(
              height: 48,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: WalledWidget(),
            )
          ],
        ),
        const SizedBox(height: 18),
        MainFeatureWidget(),
        const Divider(height: 32, thickness: 2),
        AdditionalFeatureWidget(),
        const Divider(height: 32, thickness: 2),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text('Hotels for you'),
        ),
        SizedBox(height: 16),
        SugestionHotelsWidget(),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text('Ongoing Promos'),
        ),
        SizedBox(height: 16),
        PromosWidget()
      ],
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mlaku_mlaku/features/data/datasources/firebase/cloud_service.dart';
import 'package:mlaku_mlaku/injection_container.dart';

import '../../bloc/auth/auth_bloc_bloc.dart';

class MyAccountPage extends StatelessWidget {
  MyAccountPage({super.key});
  CloudService db = sl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                BlocProvider.of<AuthBlocBloc>(context).add(AuthBlocEventLogout());
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 74,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                    radius: 70,
                    child: Icon(
                      Icons.person,
                      size: 84,
                    )),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 24),
                  padding: EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey,
                          blurRadius: 15,
                        )
                      ]),
                  child: StreamBuilder(
                      stream: db.getDataUser(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        else {
                          return Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.person),
                                title: Text("Nama"),
                                subtitle: Text(snapshot.data?['name']),
                              ),
                              const ListTile(
                                leading: Icon(Icons.location_on_outlined),
                                title: Text("Negara"),
                                subtitle: Text("Indonesia"),
                              ),
                              ListTile(
                                leading: Icon(Icons.home_work_outlined),
                                title: Text("Alamat"),
                                subtitle: Text(snapshot.data?['provience']),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          );
                        }
                      }),
                ),
              )
            ],
          ),
        ));
  }
}

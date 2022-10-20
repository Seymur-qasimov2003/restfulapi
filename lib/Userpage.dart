import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restfulapi/Service/UserService.dart';

import 'model/UserModel.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserService _userServiceService = UserService();
  List<UserModelData> users = [];
  bool? isLoading;
  @override
  void initState() {
    _userServiceService.getUser().then((value) {
      if (value.data != null && value.data!.isNotEmpty) {
        setState(() {
          users = value.data;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Page"),
      ),
      body: isLoading == true
          ? ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      users[index].firstName + " " + users[index].lastName),
                  subtitle: Text(users[index].email),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(users[index].avatar),
                  ),
                );
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ree_rave/controller/search_controller.dart';
import 'package:ree_rave/models/user_model.dart';
import 'package:ree_rave/views/screens/profile_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final MySearchController searchController = Get.put(MySearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: TextFormField(
              onFieldSubmitted: (value) {
                searchController.searchUser(value);
              },
              controller: _searchController,
              decoration: InputDecoration(
                filled: false,
                hintStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                hintText: 'Search',
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          searchController.searchResult.clear();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ))
                    : const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
          body: searchController.searchResult.isEmpty
              ? const Center(
                  child: Text(
                    'Search for User',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: searchController.searchResult.length,
                  itemBuilder: (BuildContext context, index) {
                    User user = searchController.searchResult[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ProfileScreen(uid: user.uid);
                        }));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePic),
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ));
    });
  }
}

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../providers/places_provider.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false).getPlace(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlacesProvider>(
                child: Center(child: const Text('Got no places yet')),
                builder: (ctx, provideredPlaces, ch) =>
                    provideredPlaces.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(provideredPlaces.items[i].image),
                              ),
                              title: Text(provideredPlaces.items[i].title),
                              onTap: () {},
                            ),
                            itemCount: provideredPlaces.items.length,
                          ),
              ),
      ),
    );
  }
}

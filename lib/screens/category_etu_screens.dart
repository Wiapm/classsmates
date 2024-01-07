import 'package:flutter/material.dart';
import '../widgets/fichier_item.dart';
import '../app_data.dart';

class CategoryEtuScreen extends StatelessWidget {
  static const screenRouter = "category-trips";

  const CategoryEtuScreen({super.key});
  // final String categoryId;
  //final String categoryTitle;
  //const CategoryTripsScreen(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    final routeArgument =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final CategoryId = routeArgument['id'];
    final CategoryTitle = routeArgument['title'];
    final filterdTrips = Trips_data.where((trip) {
      return trip.categories.contains(CategoryId);
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(CategoryTitle!),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, Index) {
            return TripItem(
                title: filterdTrips[Index].title,
                imageUrl: filterdTrips[Index].imageUrl,
                duration: filterdTrips[Index].duration,
                tripType: filterdTrips[Index].tripType,
                season: filterdTrips[Index].season);
          },
          itemCount: filterdTrips.length,
        ));
  }
}

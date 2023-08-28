import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

void scheduleAutoActivation() {
  // Get the current date and time
  final now = DateTime.now();

  // Calculate the time until the next desired activation time (e.g., 9:00 AM)
  final desiredTime = DateTime(now.year, now.month, now.day, 9, 0, 0);
  Duration timeUntilActivation = desiredTime.difference(now);
  if (timeUntilActivation.isNegative) {
    // If the desired time has already passed today, add 1 day to the duration
    timeUntilActivation += Duration(days: 1);
  }

  // Schedule the auto activation function to run at the desired time every day
  Timer(timeUntilActivation, () {
    autoActivateOrders();

    // Schedule the next activation for the next day
    scheduleAutoActivation();
  });
}

void autoActivateOrders() async {
  final currentDate = DateTime.now();

  // Retrieve all documents from the "orders" collection
  final QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('orders')
      .get();

  // Iterate over the documents and check the "lastDay" field
  for (final DocumentSnapshot doc in snapshot.docs) {
    final orderData = doc.data() as Map<String, dynamic>;

    if (orderData.containsKey('lastDay')) {
      final lastDayTimestamp = orderData['lastDay'] as Timestamp;
      final lastDay = lastDayTimestamp.toDate();

      // Compare the "lastDay" with the current date
      if (lastDay.isBefore(currentDate)) {
        // Delete the document if the "lastDay" has passed
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(doc.id)
            .delete();
      }
    }
  }
}
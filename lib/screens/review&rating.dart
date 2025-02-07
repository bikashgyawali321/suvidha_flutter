import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/review_rating_model/review_rating.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/widgets/custom_button.dart';
import 'package:suvidha/widgets/custom_snackbar.dart';
import 'package:suvidha/widgets/form_bottom_sheet_header.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewAndRatingProvider extends ChangeNotifier {
  final BuildContext context;
  late BackendService _backendService;
  final bool isForBooking;
  ReviewAndRatingProvider(
      {required this.context, required this.id, required this.isForBooking}) {
    initialize();
  }
  late final ratingController;
  bool loading = false;
  final String id;

  NewReviewRatingModel? newReviewRatingModel;
  String? ratingError;

  void initialize() {
    _backendService = Provider.of<BackendService>(
      context,
      listen: false,
    );
    ratingController = TextEditingController();
    newReviewRatingModel = NewReviewRatingModel(
      bookingId: isForBooking == true ? id : null,
      orderId: isForBooking == false ? id : null,
      rating: 0,
      review: '',
    );
  }

  Future<void> addReviewRating() async {
    if (newReviewRatingModel?.rating == 0) {
      ratingError = "Please rate the service";
      notifyListeners();
      return;
    }
    loading = true;
    notifyListeners();
    final response = await _backendService.createReviewRatings(
      newReviewRatingModel: newReviewRatingModel!,
    );
    if (response.statusCode == 200) {
      SnackBarHelper.showSnackbar(
        context: context,
        successMessage: response.message,
      );
    } else {
      SnackBarHelper.showSnackbar(
        context: context,
        errorMessage: response.errorMessage,
      );
    }
    loading = false;
    context.pop();
    notifyListeners();
  }
}

class ReviewAndRatingBottomSheet extends StatelessWidget {
  const ReviewAndRatingBottomSheet({
    super.key,
    required this.id,
    required this.isForBooking,
  });
  final String id;
  final bool isForBooking;
  static void show({
    required BuildContext context,
    required String id,
    required bool isForBooking,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ChangeNotifierProvider(
        create: (context) => ReviewAndRatingProvider(
          context: context,
          id: id,
          isForBooking: isForBooking,
        ),
        builder: (context, child) => ReviewAndRatingBottomSheet(
          id: id,
          isForBooking: isForBooking,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewAndRatingProvider>(
      builder: (context, provider, child) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBottomSheetHeader(title: 'Review & Rating'),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Text(
                      'How was your experience? Rate and let us know!',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 10),
                    RatingBar.builder(
                      maxRating: 5,
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 50,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      glow: false,
                      onRatingUpdate: (rating) {
                        provider.newReviewRatingModel!.rating = rating;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (provider.ratingError != null)
                          Text(
                            provider.ratingError!,
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Write your review here.....',
                      ),
                      maxLines: 2,
                      maxLength: 100,
                      onChanged: (value) {
                        provider.newReviewRatingModel?.review = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: CustomButton(
                            label: 'Skip',
                            onPressed: () => context.pop(),
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomButton(
                            label: 'Submit',
                            onPressed: () => provider.addReviewRating(),
                            loading: provider.loading,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
  ReviewAndRatingProvider({required this.context, required this.serviceId}) {
    initialize();
  }
  late final ratingController;
  bool loading = false;
  final String serviceId;

  NewReviewRatingModel? newReviewRatingModel;

  void initialize() {
    _backendService = Provider.of<BackendService>(
      context,
    );
    ratingController = TextEditingController();
    newReviewRatingModel = NewReviewRatingModel(
      serviceId: serviceId,
      rating: 0,
      review: '',
    );
  }

  Future<void> addReviewRating() async {
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
  const ReviewAndRatingBottomSheet({super.key, required this.serviceId});
  final String serviceId;

  static void show({required BuildContext context, required String serviceId}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ChangeNotifierProvider(
        create: (context) =>
            ReviewAndRatingProvider(context: context, serviceId: serviceId),
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
                    Text('Rate the service'),
                    SizedBox(height: 5),
                    RatingBar.builder(
                      maxRating: 5,
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        provider.newReviewRatingModel!.rating = rating;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Share your experience(optional)',
                        hintText: 'Write your review here',
                      ),
                      onChanged: (value) {
                        provider.newReviewRatingModel?.review = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: CustomButton(
                            label: 'Skip',
                            onPressed: () => context.pop(),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomButton(
                          label: 'Submit',
                          onPressed: () => provider.addReviewRating(),
                          loading: provider.loading,
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

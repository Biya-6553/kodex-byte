import 'package:flutter/foundation.dart';

import '../../../core/constants/app_assets.dart';
import '../../../data/models/provider_model.dart';

class ServiceProviderViewModel extends ChangeNotifier {
  final ProviderModel provider = const ProviderModel(
    id: '1',
    name: 'Dr. Aisha Rahman',
    specialty: 'Prenatal Massage Specialist',
    rating: 4.9,
    reviewCount: '1.6k',
    location: 'Dubai, UAE',
    yearsExperience: 5,
    aboutText:
        'Dr. Aisha Rahman is a highly skilled and compassionate Prenatal Massage Specialist with over 5 years of experience in providing exceptional care to expecting mothers. She is committed to ensuring the well-being of clients through personalized treatment and professional support.',
    languages: [
      LanguageModel(flagAsset: AppAssets.flagAmerica, name: 'English'),
      LanguageModel(flagAsset: AppAssets.flagUae, name: 'Arabic'),
    ],
    certifications: [
      'Licensed Midwife',
      'Certified Prenatal Massage Therapist',
      'Additional certifications in pregnancy therapies',
    ],
    ratingBreakdown: RatingBreakdown(
      averageRating: 4.6,
      totalReviews: 367,
      star5: 0.80,
      star4: 0.55,
      star3: 0.30,
      star2: 0.20,
      star1: 0.10,
    ),
    reviews: [
      ReviewModel(
        id: 'r1',
        reviewerName: 'Ayesha khan',
        reviewerAvatar: AppAssets.review1,
        rating: 5,
        title: 'A Lifesaver During My Pregnancy!',
        body:
            'This app has been an amazing companion throughout my journey. The weekly baby growth updates are both exciting and informative, and the reminders for appointments keep me on track.',
        imageAssets: [AppAssets.review1, AppAssets.review2, AppAssets.review1],
      ),
    ],
    listedServices: [
      ServiceModel(
        id: 's1',
        title: 'Calming Prenatal Massage',
        description:
            'Experience gentle care designed to reduce stress, ease body aches, and support your pregnancy journey.',
        imagePath: AppAssets.service1,
        providerName: 'Dr. Aisha Rahman',
        providerAvatar: AppAssets.woman,
        startingPrice: 40,
        currency: '\$',
        durationMinutes: 60,
        location: 'Dubai',
        rating: 4.2,
        reviewCount: '1.5k',
      ),
    ],
  );

  void onChat() {}
  void onBookNow() {}
  void onBack() {}
  void onFavourite() {}
  void onNotification() {}
  void onSeeAllServices() {}
}

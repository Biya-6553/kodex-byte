import '../models/expert_model.dart';

class ExpertRepository {
  Future<List<ExpertModel>> getExperts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Returning mock data that was previously hardcoded
    return [
      ExpertModel(
        id: '1',
        name: 'Dr. Aisha Rahman',
        specialty: 'Prenatal Massage Specialist',
        rating: 4.9,
        reviewCount: 1600,
        tags: ['Prenatal', 'Postpartum'],
        isTopRated: true,
        offersHomeVisit: true,
        offersAtProvider: true,
        location: 'Dubai',
        avatarUrl: 'assets/images/Group 2085664557.png', // Temporary local asset
      ),
      ExpertModel(
        id: '2',
        name: 'Sarah Smith',
        specialty: 'Pediatric Sleep Consultant',
        rating: 4.8,
        reviewCount: 850,
        tags: ['Sleep', 'Newborn'],
        isTopRated: false,
        offersHomeVisit: false,
        offersAtProvider: true,
        location: 'Abu Dhabi',
        avatarUrl: 'assets/images/Group 2085664557.png',
      ),
      ExpertModel(
        id: '3',
        name: 'Dr. Fatima Ali',
        specialty: 'Lactation Consultant',
        rating: 5.0,
        reviewCount: 2100,
        tags: ['Breastfeeding', 'Postpartum'],
        isTopRated: true,
        offersHomeVisit: true,
        offersAtProvider: false,
        location: 'Sharjah',
        avatarUrl: 'assets/images/Group 2085664557.png',
      ),
      ExpertModel(
        id: '4',
        name: 'Emma Johnson',
        specialty: 'Child Psychologist',
        rating: 4.7,
        reviewCount: 420,
        tags: ['Toddler', 'Behavior'],
        isTopRated: false,
        offersHomeVisit: true,
        offersAtProvider: true,
        location: 'Dubai',
        avatarUrl: 'assets/images/Group 2085664557.png',
      ),
      ExpertModel(
        id: '5',
        name: 'Dr. John Doe',
        specialty: 'Pediatrician',
        rating: 4.9,
        reviewCount: 3000,
        tags: ['Health', 'Vaccine'],
        isTopRated: true,
        offersHomeVisit: false,
        offersAtProvider: true,
        location: 'Dubai',
        avatarUrl: 'assets/images/Group 2085664557.png',
      ),
      ExpertModel(
        id: '6',
        name: 'Jane Doe',
        specialty: 'Speech Therapist',
        rating: 4.6,
        reviewCount: 310,
        tags: ['Speech', 'Toddler'],
        isTopRated: false,
        offersHomeVisit: true,
        offersAtProvider: false,
        location: 'Abu Dhabi',
        avatarUrl: 'assets/images/Group 2085664557.png',
      ),
    ];
  }
}

import 'package:restorder/models/category/category_details_response.dart';

class CategoryDetailsViewModel {
  getCategoryDetails() => <CategoryDetailsResponse>[
    CategoryDetailsResponse(id: 1, dashboardId: 1, categoryId: 1, description: 'Chiken fried bacon consists of bacon strips dredged batter and deep fried, like chicken fried steak.'),
    CategoryDetailsResponse(id: 1, dashboardId: 1, categoryId: 2, description: 'An authentic cajun meal is usually a three - pot affair, with one pot dedicated to the main dish, one dedicated to streamed rice, special made sausages, or some seafood dish, and the third containing whatever vegetable is plentiful or available.'),


    CategoryDetailsResponse(id: 1, dashboardId: 1, categoryId: 3, description: ''),
    CategoryDetailsResponse(id: 1, dashboardId: 1, categoryId: 4, description: ''),
  ];
}

import 'package:restorder/models/category/category_response.dart';

class CategoryViewModel {
  getCategory() => <CategoryResponse>[
        CategoryResponse(id: 1, dashboardId: 1, title: 'Chicken fried bacon', ratting: 4.0, indiaPrice: 180.0, weight:'250 GM'),
        CategoryResponse(id: 2, dashboardId: 1, title: 'Cajun cuisine', ratting:4.0, indiaPrice: 150.0, weight: '150 GM'),
        CategoryResponse(id: 3, dashboardId: 1, title: 'Bear claw', ratting: 5.0, indiaPrice: 210.0, weight:'5 Pieces'),
        CategoryResponse(id: 4, dashboardId: 1, title: 'Chiken nugget', ratting:4.0, indiaPrice: 250.0, weight:'5 Pieces'),

        CategoryResponse(id: 5, dashboardId: 2, title: 'Kung pao chicken', ratting: 4.0, indiaPrice: 115.0, weight:'1 Plate'),
        CategoryResponse(id: 6, dashboardId: 2, title: 'Fried rice', ratting: 3.5, indiaPrice: 120.0, weight:'1 Plate'),
        CategoryResponse(id: 7, dashboardId: 2, title: 'Chinese stickly rice', ratting: 2.0, indiaPrice: 150.0, weight:'1 Plate'),
        CategoryResponse(id: 7, dashboardId: 2, title: 'Chinese noodles', ratting: 1.0, indiaPrice: 100.0, weight:'1 Plate')
      ];
}

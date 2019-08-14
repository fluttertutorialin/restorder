import 'package:restorder/models/dashboard/dashboard_response.dart';

class DashboardViewModel {
  List<DashBoardResponse> dashboardDispatchItems;

  DashboardViewModel({this.dashboardDispatchItems});

  getDashboard() => <DashBoardResponse>[
        DashBoardResponse(id: 1, title: 'American', ratting: 4.0, totalItems: 4),
        DashBoardResponse(id: 2, title: 'Chinese', ratting: 4.0, totalItems: 4),
        DashBoardResponse(id: 3, title: 'Italian', ratting: 4.5, totalItems: 3),
        DashBoardResponse(id: 4, title: 'Japanese', ratting: 3.0, totalItems: 4),
        DashBoardResponse(id: 5, title: 'Indian', ratting: 4.0, totalItems: 4),
        DashBoardResponse(id: 6, title: 'France', ratting: 5.0, totalItems: 1),
        DashBoardResponse(id: 7, title: 'German', ratting: 4.0, totalItems: 0)
      ];
}

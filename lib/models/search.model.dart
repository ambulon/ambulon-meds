class SearchModel {
  List strList;
  // List<List<dynamic>> data;

  SearchModel(this.strList);

  SearchModel.fromJson(Map<String, dynamic> json, List strListEvent) {
    // List dataTemp = dataListEvent;
    // if (dataTemp != null || dataTemp == []) {
    //   dataTemp[0] = ['data', 'for', strListEvent.last];
    // } else {
    //   dataTemp.add(['data', 'for', strListEvent.last]);
    // }
    // adding data from this json
    SearchModel(
      this.strList = strListEvent,
      // this.data = dataTemp,
    );
  }
}

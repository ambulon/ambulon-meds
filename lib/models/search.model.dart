class SearchModel {
  List strList;
  List<SingleSearchResultModel> dataList;

  SearchModel(this.strList, this.dataList);

  SearchModel.fromJson(Map<String, dynamic> json, List strListEvent, List<SingleSearchResultModel> ssrmL) {
    SingleSearchResultModel ssrm = SingleSearchResultModel.fromJson(json, strListEvent.last);
    ssrmL.add(ssrm);
    SearchModel(
      this.strList = strListEvent,
      this.dataList = ssrmL,
    );
  }
}

class SingleSearchResultModel {
  String name;
  List details;
  SingleSearchResultModel(this.name, this.details);
  SingleSearchResultModel.fromJson(Map<String, dynamic> json, String str) {
    SingleSearchResultModel(
      this.name = str,
      this.details = str.split(''),
    );
  }
}

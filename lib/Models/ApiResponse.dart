class ApiResponse {
  String? message;
  var data;

  ApiResponse({this.data, this.message});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) this.message = json['message'];
    if (json['data'] != null) {
      this.data = json['data'];
    }
  }
}

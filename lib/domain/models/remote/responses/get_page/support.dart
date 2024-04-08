import 'package:equatable/equatable.dart';

class SupportResponse extends Equatable {
  final String? url;
  final String? text;

  SupportResponse({
    this.url,
    this.text,
  });

  factory SupportResponse.fromMap(Map<String, dynamic> map) {
    return SupportResponse(
      url:map['url'] != null ? map['url'] as String : null,
      text:map['text'] != null ? map['text'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => {
    'url': url,
    'text': text,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [url, text];
}

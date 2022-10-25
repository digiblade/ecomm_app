import "../Util/consturl.dart";

class DocumentModel {
  String? documentId;
  String? documentLabel;
  String? documentName;
  String? parentId;
  DocumentModel({
    this.documentId,
    this.documentLabel,
    this.documentName,
    this.parentId,
  });
}

List<DocumentModel> getDocuments(apiDocList) {
  List<DocumentModel> docList = [];
  for (dynamic doc in apiDocList) {
    DocumentModel docObj = DocumentModel(
      documentId: doc['document_id'],
      documentLabel: doc['document_label'],
      documentName: doc['document_path'],
      parentId: doc['document_parentid'],
    );
    docList.add(docObj);
  }
  return docList;
}

getPathFromModel(List<DocumentModel> docs) {
  if (docs.length > 0) {
    DocumentModel doc = docs[0];
    String? label = doc.documentLabel;
    String? name = doc.documentName;
    String path = "$imageurl$label/$name";
    return path;
  }
  return "";
}

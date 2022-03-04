class NotesDAO {
  int? idNota;
  String? titulo;
  String? dscNota;

  NotesDAO({this.idNota, this.titulo, this.dscNota});
  factory NotesDAO.fromMap(Map<String, dynamic> noteMap) {
    return NotesDAO(
        titulo: noteMap['titulo'],
        idNota: noteMap['idNota'],
        dscNota: noteMap['dscNota']);
  }
}

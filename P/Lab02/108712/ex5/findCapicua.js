function findCapicuas() {
    var capicuas = db.phones.find({
      $where: function() {
        var numberStr = this.components.number.toString();
        return numberStr === numberStr.split("").reverse().join("");
      }
    });
    return capicuas.toArray();
  }
  
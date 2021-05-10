var Curso = function(nombre, desc, descCorta, costo, categoria) {
	this.nombre = nombre;
	this.desc = desc;
	this.descCorta = descCorta;
    this.costo = costo;
    this.categoria = categoria;
	//this.foto = foto;
    //this.foto = video;
};

Curso.prototype = {	
	isValid: function() {
		if (!this.nombre || !this.desc || !this.descCorta || !this.costo || !this.categoria) return false;
		return true;
	}
};
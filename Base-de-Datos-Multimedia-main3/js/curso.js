var Curso = function(nombre, desc, costo, categoria) {
	this.nombre = nombre;
	this.desc = desc;
    this.costo = costo;
    this.categoria = categoria;
	//this.foto = foto;
    //this.foto = video;
};

Curso.prototype = {	
	isValid: function() {
		if (!this.nombre || !this.desc || !this.costo || !this.categoria) return false;
		return true;
	}
};
var Categoria = function(nombre, desc) {
	this.nombre = nombre;
	this.desc = desc;
	//this.foto = foto;
};

Categoria.prototype = {	
	isValid: function() {
		if (!this.nombre || !this.desc) return false;
		return true;
	}
};
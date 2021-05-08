var Usuario = function(rol, nombre, apellidoPat, apellidoMat, contrasena, email, telefono, fecha_registro) {
	this.rol = rol;
	this.nombre = nombre;
	this.apellidoPat = apellidoPat;
	this.apellidoMat = apellidoMat;
	this.contrasena = contrasena;
	this.email = email;
	this.telefono = telefono;
	//this.foto = foto;
	this.fecha_registro = fecha_registro;
};

Usuario.prototype = {	
	isValid: function() {
		if (!this.rol || !this.nombre || !this.apellidoPat || !this.apellidoMat || !this.contrasena || !this.email || !this.telefono || !this.fecha_registro) return false;
		return true;
	}
};
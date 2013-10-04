/**
 * User
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 *
 */

module.exports = {

	schema: true,

	attributes: {

		email: {
			type:'string',
			required:true,
			email:true,
			unique:true
		}

	},

	admin: {
		type: 'boolean',
		defaultsTo: false
	},

	toJSON: function() {
		var obj = this.toObject();
		delete obj._csrf;
		return obj;
	}

};

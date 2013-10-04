/**
 * SpeciesController
 *
 * @module		:: Controller
 * @description	:: Contains logic for handling requests.
 */

module.exports = {

  /* e.g.
  sayHello: function (req, res) {
    res.send('hello world!');
  }
  */
  
  /**
   * /species/create
   */ 
  create: function (req,res) {

    // This will render the view: 
    // C:\Users\jknutson\Dropbox\workspace\anansi/views/species/create.ejs
    res.view();

  },


  /**
   * /species/destroy
   */ 
  destroy: function (req,res) {

    // This will render the view: 
    // C:\Users\jknutson\Dropbox\workspace\anansi/views/species/destroy.ejs
    res.view();

  },


  /**
   * /species/tag
   */ 
  tag: function (req,res) {

    // This will render the view: 
    // C:\Users\jknutson\Dropbox\workspace\anansi/views/species/tag.ejs
    res.view();

  },


  /**
   * /species/like
   */ 
  like: function (req,res) {

    // This will render the view: 
    // C:\Users\jknutson\Dropbox\workspace\anansi/views/species/like.ejs
    res.view();

  }

};

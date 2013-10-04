/**
 * LocationController
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
   * /location/create
   */ 
  create: function (req,res) {

    // This will render the view: 
    // C:\Users\jknutson\Dropbox\workspace\anansi/views/location/create.ejs
    res.view();

  },


  /**
   * /location/destroy
   */ 
  destroy: function (req,res) {

    // This will render the view: 
    // C:\Users\jknutson\Dropbox\workspace\anansi/views/location/destroy.ejs
    res.view();

  },


  /**
   * /location/tag
   */ 
  tag: function (req,res) {

    // This will render the view: 
    // C:\Users\jknutson\Dropbox\workspace\anansi/views/location/tag.ejs
    res.view();

  },


  /**
   * /location/like
   */ 
  like: function (req,res) {

    // This will render the view: 
    // C:\Users\jknutson\Dropbox\workspace\anansi/views/location/like.ejs
    res.view();

  }

};

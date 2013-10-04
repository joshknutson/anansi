/**
 * UserController
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
   * /user/create
   */
  create: function (req,res) {

    // This will render the view:
    // C:\Users\jknutson\Dropbox\workspace\anansi/views/user/create.ejs
    res.view();

  }

};

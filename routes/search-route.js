let express = require('express'),
    router = express.Router(),
    SearchController = require('../controllers/search-controller');

router
    .get('/', isLoggedIn,  SearchController.open)

    .post('/loadParalel', isLoggedIn , SearchController.loadParalel)

    .post('/loadTable', isLoggedIn, SearchController.loadTable);

/* Proteje las rutas */
function isLoggedIn(req, res, next) {
    sess = req.session;
    if (sess.usuarioDatos)
        return next();
    res.redirect('/')
}



module.exports = router;
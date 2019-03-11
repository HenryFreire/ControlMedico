let express = require('express'),
    router = express.Router(),
    ConsultasController = require('../controllers/consultation-controller');

router
    .get('/', isLoggedIn, ConsultasController.open)

    .get('/verId', isLoggedIn, ConsultasController.viewDetail)

    .get('/delete', isLoggedIn, ConsultasController.delete);

/* Proteje las rutas */
function isLoggedIn(req, res, next) {
    sess = req.session;
    if (sess.usuarioDatos)
        return next();
    res.redirect('/')
}


module.exports = router;
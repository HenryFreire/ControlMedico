let express = require('express'),
    router = express.Router(),
    PanelController = require('../controllers/panel-controller');

router
    .get('/', isLoggedIn,  PanelController.panel)

    .post('/rango', isLoggedIn, PanelController.rango);


/* Proteje las rutas */
function isLoggedIn(req, res, next) {
    sess = req.session;
    if (sess.usuarioDatos)
        return next();
    res.redirect('/')
}

module.exports = router;
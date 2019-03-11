let express = require('express'),
    router = express.Router(),
    ConfigurationController = require('../controllers/configuration-controller');

router
    .get('/', isLoggedIn, ConfigurationController.configuration)

    .post('/changePassword', isLoggedIn, ConfigurationController.changePassword);

/* Proteje las rutas */
function isLoggedIn(req, res, next) {
    sess = req.session;
    if (sess.usuarioDatos)
        return next();
    res.redirect('/')
}

module.exports = router;
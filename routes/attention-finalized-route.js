let express = require('express'),
    router = express.Router(),
    AttentionFinalizedController = require('../controllers/authenticacion-controller');




function isLoggedIn(req, res, next) {
    sess = req.session;
    if (sess.usuarioDatos)
        return next();
    res.redirect('/')
}

module.exports = router;
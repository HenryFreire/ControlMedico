let express = require('express'),
    router = express.Router(),
    ProfileController = require('../controllers/profile-controller');


router
        .get('/', isLoggedIn , ProfileController.open)

        .post('/upload', isLoggedIn , ProfileController.upload)

        .post('/reload', isLoggedIn , ProfileController.reload);

function isLoggedIn(req, res, next) {
    sess = req.session;
    if (sess.usuarioDatos)
        return next();
    res.redirect('/')
}

module.exports = router;
let express = require('express'),
    router = express.Router(),
    FormAttentionController = require('../controllers/form-attention-controller');

router
    .get('/loadPerson', isLoggedIn, FormAttentionController.loadPerson )

    .post('/newAntecedent', isLoggedIn, FormAttentionController.newAntecedent )

    .post('/newAllergie', isLoggedIn, FormAttentionController.newAllergie )

    .post('/newdisease', isLoggedIn, FormAttentionController.newDisease )

    .post('/deleteAntecedent', isLoggedIn, FormAttentionController.deleteAntecedent )

    .post('/deleteAllergie', isLoggedIn, FormAttentionController.deleteAllergie )

    .post('/deleteDisease', isLoggedIn, FormAttentionController.deleteDisease )

    .get('/getCie10', isLoggedIn, FormAttentionController.getCie10)

    .post('/createHistory', isLoggedIn, FormAttentionController.createHistory)

    .post('/newAttention', isLoggedIn, FormAttentionController.newAttention)

    .post('/datosMedicos', isLoggedIn, FormAttentionController.editDatosMedicos);

/* Proteje las rutas */
function isLoggedIn(req, res, next) {
    sess = req.session;
    if (sess.usuarioDatos)
        return next();
    res.redirect('/')
}

module.exports = router;